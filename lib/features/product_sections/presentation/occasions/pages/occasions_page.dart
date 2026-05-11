import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/widgets/app_loading_widget.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/product_sections/domain/entities/occasion_entity.dart';
import 'package:flower/features/product_sections/presentation/occasions/cubit/occasions_products_cubit.dart';
import 'package:flower/features/product_sections/presentation/occasions/widgets/occasion_error_view.dart';
import 'package:flower/features/product_sections/presentation/occasions/widgets/occasion_tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OccasionsPage extends StatefulWidget {
  final String? initialOccasionId;
  const OccasionsPage({super.key, this.initialOccasionId});

  @override
  State<OccasionsPage> createState() => _OccasionsPageState();
}

class _OccasionsPageState extends State<OccasionsPage> {
  final ScrollController _scrollController = ScrollController();
  late final OccasionsProductsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit =
        getIt<OccasionsProductsCubit>()
          ..doEvent(
          LoadInitialDataEvent(initialOccasionId: widget.initialOccasionId),
        );
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    _cubit.doEvent(HandleScrollEvent(_scrollController));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Occasion'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child:
              BlocSelector<
                OccasionsProductsCubit,
                OccasionsProductsState,
                BaseState<List<OccasionEntity>>
              >(
                selector: (state) => state.occasionsState,
                builder: (context, occasionState) {
                  final occasions = occasionState.data ?? [];

                  if (occasionState.isLoading && occasions.isEmpty) {
                    return const AppLoadingWidget();
                  }

                  if (occasionState.errorMessage != null && occasions.isEmpty) {
                    return OccasionErrorView(
                      message: occasionState.errorMessage!,
                      onRetry: () => context
                          .read<OccasionsProductsCubit>()
                          .doEvent(RetryEvent()),
                    );
                  }

                  if (occasions.isEmpty) {
                    return const Center(child: Text('No occasions found.'));
                  }

                  return OccasionTabsView(
                    occasions: occasions,
                    scrollController: _scrollController,
                  );
                },
              ),
        ),
      ),
    );
  }
}
