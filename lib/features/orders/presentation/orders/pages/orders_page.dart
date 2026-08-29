import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/orders_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_error_widget.dart';
import 'package:flower/features/orders/domain/models/order_model.dart';
import 'package:flower/features/orders/presentation/orders/cubit/orders_cubit.dart';
import 'package:flower/features/orders/presentation/orders/cubit/orders_event.dart';
import 'package:flower/features/orders/presentation/orders/widgets/order_card.dart';
import 'package:flower/features/orders/presentation/orders/widgets/order_card_shimmer.dart';
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
      if (mounted) {
        context.read<OrdersCubit>().doEvent(const GetOrdersEvent());
      }
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
      if (!controller.hasClients) {
        continue;
      }

      if (controller.position.maxScrollExtent <= 0) {
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
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: AppColors.textPrimary,
          ),
        ),

        title: Text(
          OrdersConstants.myOrders,
          style: getSemiBoldStyle(
            context: context,
            fontSize: 20,
            color: AppColors.textPrimary,
          ),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(58),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
            child: Container(
              height: 44,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TabBar(
                controller: _tabController,

                isScrollable: false,

                dividerColor: Colors.transparent,

                indicatorSize: TabBarIndicatorSize.tab,

                indicator: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),

                labelColor: AppColors.primary,

                unselectedLabelColor: AppColors.textSecondary,

                labelStyle: getSemiBoldStyle(
                  context: context,
                  fontSize: FontSizeManager.s11,
                  color: AppColors.primary,
                ),

                unselectedLabelStyle: getRegularStyle(
                  context: context,
                  fontSize: FontSizeManager.s11,
                  color: AppColors.textSecondary,
                ),

                splashFactory: NoSplash.splashFactory,

                overlayColor: WidgetStateProperty.all(Colors.transparent),

                tabs: [
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(OrdersConstants.pending),
                    ),
                  ),
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(OrdersConstants.inProgress),
                    ),
                  ),
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(OrdersConstants.canceled),
                    ),
                  ),
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(OrdersConstants.completed),
                    ),
                  ),
                ],
              ),
            ),
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
    // Initial loading
    if (state.isLoading) {
      return ListView.builder(
        controller: _scrollControllers[0],
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        itemCount: 4,
        itemBuilder: (context, index) {
          return const OrderCardShimmer();
        },
      );
    }

    // Error
    if (state.errorMessage != null) {
      return Center(
        child: AppErrorWidget(
          errorMessage: state.errorMessage!,
          onRetry: () {
            context.read<OrdersCubit>().doEvent(const GetOrdersEvent());
          },
        ),
      );
    }

    return TabBarView(
      controller: _tabController,
      physics: const BouncingScrollPhysics(),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            emptyMessages[index],
            textAlign: TextAlign.center,
            style: getRegularStyle(
              context: context,
              fontSize: FontSizeManager.s16,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollControllers[index],
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: orders.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, i) {
        // Loading more
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
