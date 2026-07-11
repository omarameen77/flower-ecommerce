import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/orders_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_error_widget.dart';
import 'package:flower/features/checkout_and_orders/domain/models/order_model.dart';
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

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _scrollControllers = List.generate(4, (_) => ScrollController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrdersCubit>().doEvent(const GetOrdersEvent());
    });
    for (final controller in _scrollControllers) {
      controller.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (final controller in _scrollControllers) {
      controller.removeListener(_onScroll);
      controller.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    for (final controller in _scrollControllers) {
      if (!controller.hasClients || controller.position.maxScrollExtent <= 0) {
        continue;
      }
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        context.read<OrdersCubit>().doEvent(const LoadMoreOrdersEvent());
        break;
      }
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
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: OrdersConstants.pending),
            Tab(text: OrdersConstants.inProgress),
            Tab(text: OrdersConstants.canceled),
            Tab(text: OrdersConstants.completed),
          ],
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
        controller: _scrollControllers[0],
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        itemCount: 4,
        itemBuilder: (context, index) => const OrderCardShimmer(),
      );
    }

    if (state.errorMessage != null) {
      return AppErrorWidget(
        errorMessage: state.errorMessage!,
        onRetry: () =>
            context.read<OrdersCubit>().doEvent(const GetOrdersEvent()),
      );
    }

    return TabBarView(
      controller: _tabController,
      children: [
        _buildOrderList(state.pendingOrders, state.isLoadingMore, 0),
        _buildOrderList(state.inProgressOrders, state.isLoadingMore, 1),
        _buildOrderList(state.canceledOrders, state.isLoadingMore, 2),
        _buildOrderList(state.completedOrders, state.isLoadingMore, 3),
      ],
    );
  }

  Widget _buildOrderList(
    List<OrderModel> orders,
    bool isLoadingMore,
    int index,
  ) {
    if (orders.isEmpty) {
      final emptyMessages = [
        OrdersConstants.noPendingOrders,
        OrdersConstants.noInProgressOrders,
        OrdersConstants.noCanceledOrders,
        OrdersConstants.noCompletedOrders,
      ];
      return Center(
        child: Text(
          emptyMessages[index],
          style: getRegularStyle(
            context: context,
            fontSize: FontSizeManager.s16,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollControllers[index],
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: orders.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, i) {
        if (i == orders.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSize.s8),
            child: OrderCardShimmer(),
          );
        }
        return OrderCard(order: orders[i]);
      },
    );
  }
}
