import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/localization_constants/track_order_constants.dart';
import 'package:flower/core/resources/app_svgs.dart';
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
import 'package:flower/features/track_order/presentation/widgets/order_items_widget.dart';
import 'package:flower/features/track_order/presentation/widgets/status_tracker_widget.dart';
import 'package:flower/features/track_order/presentation/widgets/total_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      _cubit?.doEvent(
        WatchOrder(orderId: widget.orderId, orderData: widget.orderData),
      );
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimary,
          ),
        ),
        title: Text(
          TrackOrderConstants.trackOrder,
          style: getMediumStyle(
            context: context,
            fontSize: 20,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: BlocConsumer<TrackOrderCubit, TrackOrderState>(
        listener: (context, state) {
          if (state.confirmSuccess) {
            CustomSnackBar.success(context, TrackOrderConstants.orderConfirmed);

            context.read<TrackOrderCubit>().resetConfirmSuccess();
          }

          if (state.confirmDeliveryState.errorMessage != null) {
            CustomSnackBar.error(
              context,
              state.confirmDeliveryState.errorMessage!,
            );
          }
        },
        builder: (context, state) {
          if (widget.orderId.isEmpty) {
            return _buildMessage(TrackOrderConstants.orderNotFound);
          }

          if (state.orderData.isLoading) {
            return const AppLoadingWidget();
          }

          if (state.orderData.errorMessage != null) {
            return _buildMessage(state.orderData.errorMessage!, isError: true);
          }

          final entity = state.orderData.data;

          if (entity == null) {
            return _buildMessage(TrackOrderConstants.orderNotFound);
          }

          final isDelivered =
              entity.order?.isDelivered == true ||
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

  Widget _buildMessage(String message, {bool isError = false}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: getRegularStyle(
            context: context,
            fontSize: 14,
            color: isError ? AppColors.error : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildTrackingView(TrackOrderEntity entity) {
    final order = entity.order;
    final items = order?.orderItems ?? [];

    final isArrived =
        entity.state?.isArrived == true ||
        entity.order?.state?.isArrived == true;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderSummary(entity),

          const SizedBox(height: 16),

          _buildDriverSection(entity),

          const SizedBox(height: 24),

          Text(
            TrackOrderConstants.orderStatus,
            style: getSemiBoldStyle(
              context: context,
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 10),

          StatusTrackerWidget(entity: entity),

          if (isArrived) ...[
            const SizedBox(height: 16),

            ConfirmDeliveryButton(orderId: widget.orderId),
          ],

          if (items.isNotEmpty) ...[
            const SizedBox(height: 24),

            Text(
              TrackOrderConstants.orderItems,
              style: getSemiBoldStyle(
                context: context,
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 10),
            OrderItemsWidget(items: items),
          ],
          if (order != null) ...[
            const SizedBox(height: 16),
            TotalSectionWidget(order: order),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderSummary(TrackOrderEntity entity) {
    final order = entity.order;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.access_time_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TrackOrderConstants.estimatedArrival,
                      style: getSemiBoldStyle(
                        context: context,
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      TrackOrderConstants.estimatedArrivalTime,
                      style: getRegularStyle(
                        context: context,
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.local_shipping_outlined,
                color: AppColors.primary,
                size: 22,
              ),
            ],
          ),

          if (order != null) ...[
            const SizedBox(height: 14),

            Divider(height: 1, color: AppColors.divider.withValues(alpha: 0.7)),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.orderNumber ?? '',
                        style: getSemiBoldStyle(
                          context: context,
                          fontSize: 15,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        (order.state?.name ?? '').toUpperCase(),
                        style: getMediumStyle(
                          context: context,
                          fontSize: 11,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                if (order.totalPrice != null)
                  Text(
                    '${CheckoutConstants.egp}'
                    '${order.totalPrice!.toStringAsFixed(2)}',
                    style: getSemiBoldStyle(
                      context: context,
                      fontSize: 15,
                      color: AppColors.textPrimary,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDriverSection(TrackOrderEntity entity) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              TrackOrderConstants.deliveryHero,
              style: getSemiBoldStyle(
                context: context,
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 14),
          DriverInfoWidget(user: entity.user),
          const SizedBox(height: 14),
          Divider(height: 1, color: AppColors.divider.withValues(alpha: 0.7)),
          const SizedBox(height: 10),
          SizedBox(
            height: 65,
            child: SvgPicture.asset(
              AppSvgs.car,
              width: 180,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
