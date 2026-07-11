import 'package:flower/core/localization_constants/track_order_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_loading_widget.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower/features/track_order/presentation/cubit/track_order_cubit.dart';
import 'package:flower/features/track_order/presentation/cubit/track_order_event.dart';
import 'package:flower/features/track_order/presentation/widgets/confirm_delivery_button.dart';
import 'package:flower/features/track_order/presentation/widgets/delivered_view_widget.dart';
import 'package:flower/features/track_order/presentation/widgets/driver_info_widget.dart';
import 'package:flower/features/track_order/presentation/widgets/order_header_widget.dart';
import 'package:flower/features/track_order/presentation/widgets/order_items_widget.dart';
import 'package:flower/features/track_order/presentation/widgets/status_tracker_widget.dart';
import 'package:flower/features/track_order/presentation/widgets/store_info_widget.dart';
import 'package:flower/features/track_order/presentation/widgets/total_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackOrderPage extends StatefulWidget {
  final String orderId;
  final TrackOrderEntity? orderData;

  const TrackOrderPage({super.key, required this.orderId, this.orderData});

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  TrackOrderCubit? _cubit;

  @override
  void initState() {
    super.initState();
    if (widget.orderId.isEmpty) return;
    _cubit = context.read<TrackOrderCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit?.doEvent(WatchOrder(orderId: widget.orderId, orderData: widget.orderData));
    });
  }

  @override
  void dispose() {
    _cubit?.doEvent(StopWatchingOrder());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          TrackOrderConstants.trackOrder,
          style: getMediumStyle(context: context, fontSize: 20, color: AppColors.textPrimary),
        ),
      ),
      body: BlocConsumer<TrackOrderCubit, TrackOrderState>(
        listener: (context, state) {
          if (state.confirmSuccess) {
            CustomSnackBar.success(context, TrackOrderConstants.orderConfirmed);
            context.read<TrackOrderCubit>().resetConfirmSuccess();
          }
          if (state.confirmDeliveryState.errorMessage != null) {
            CustomSnackBar.error(context, state.confirmDeliveryState.errorMessage!);
          }
        },
        builder: (context, state) {
          if (widget.orderId.isEmpty) {
            return Center(
              child: Text(
                TrackOrderConstants.orderNotFound,
                style: getRegularStyle(context: context, color: AppColors.textSecondary),
              ),
            );
          }

          if (state.orderData.isLoading) {
            return const AppLoadingWidget();
          }

          if (state.orderData.errorMessage != null) {
            return Center(
              child: Text(
                state.orderData.errorMessage!,
                style: getRegularStyle(context: context, color: AppColors.error),
              ),
            );
          }

          final entity = state.orderData.data;
          if (entity == null) {
            return Center(
              child: Text(
                TrackOrderConstants.orderNotFound,
                style: getRegularStyle(context: context, color: AppColors.textSecondary),
              ),
            );
          }

          final isDelivered = entity.order?.isDelivered == true ||
              entity.order?.state?.isDelivered == true ||
              entity.state?.isDelivered == true;

          if (isDelivered) {
            return const DeliveredViewWidget();
          }

          return _buildTrackingView(entity);
        },
      ),
    );
  }

  Widget _buildTrackingView(TrackOrderEntity entity) {
    final order = entity.order;
    final store = entity.store;
    final items = order?.orderItems ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderHeaderWidget(order: order),
          const SizedBox(height: 24),
          DriverInfoWidget(user: entity.user),
          const SizedBox(height: 24),
          StatusTrackerWidget(entity: entity),
          const SizedBox(height: 24),
          if (entity.state?.isArrived == true || entity.order?.state?.isArrived == true) ...[
            ConfirmDeliveryButton(orderId: widget.orderId),
            const SizedBox(height: 24),
          ],
          if (store != null) ...[
            StoreInfoWidget(store: store),
            const SizedBox(height: 24),
          ],
          OrderItemsWidget(items: items),
          if (order != null) ...[
            const SizedBox(height: 16),
            TotalSectionWidget(order: order),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
