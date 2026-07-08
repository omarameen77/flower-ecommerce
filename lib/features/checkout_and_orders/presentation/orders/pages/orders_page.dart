import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/orders_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_error_widget.dart';
import 'package:flower/features/checkout_and_orders/presentation/orders/cubit/orders_cubit.dart';
import 'package:flower/features/checkout_and_orders/presentation/orders/cubit/orders_event.dart';
import 'package:flower/features/checkout_and_orders/presentation/orders/widgets/order_card.dart';
import 'package:flower/features/checkout_and_orders/presentation/orders/widgets/order_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrdersCubit>().doEvent(const GetOrdersEvent());
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients ||
        _scrollController.position.maxScrollExtent <= 0) {
      return;
    }
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<OrdersCubit>().doEvent(const LoadMoreOrdersEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          OrdersConstants.myOrders,
          style: getMediumStyle(
            context: context,
            fontSize: 20,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return _buildContent(context, state);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, OrdersState state) {
    if (state.isLoading) {
      return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        itemCount: 4,
        itemBuilder: (context, index) => const OrderCardShimmer(),
      );
    }

    final orders = state.filteredOrders;

    if (orders.isNotEmpty) {
      return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        itemCount: orders.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == orders.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSize.s8),
              child: OrderCardShimmer(),
            );
          }
          return OrderCard(order: orders[index]);
        },
      );
    }

    if (state.errorMessage != null) {
      return AppErrorWidget(
        errorMessage: state.errorMessage!,
        onRetry: () => context.read<OrdersCubit>().doEvent(const GetOrdersEvent()),
      );
    }

    return Center(
      child: Text(
        OrdersConstants.noActiveOrders,
        style: getRegularStyle(
          context: context,
          fontSize: FontSizeManager.s16,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
