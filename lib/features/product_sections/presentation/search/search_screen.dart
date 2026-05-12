import 'dart:async';

import 'package:flower/core/localization_constants/home_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/custom_text_field.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/search_cubit/search_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<SearchCubit>().clear();
    });
  }

  void onSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      final text = value.trim();

      if (text.isEmpty) {
        context.read<SearchCubit>().clear();
        return;
      }

      context.read<SearchCubit>().search(text);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SearchCubit>().state;
    final products = state.data ?? [];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Hero(
                tag: "search-field",
                child: Material(
                  color: Colors.transparent,
                  child: CustomTextField(
                    controller: controller,
                    hintText: HomeConstants.search,
                    onChanged: onSearch,
                    prefixIcon: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: state.isLoading
                  ? Center(
                      child: Text(
                        HomeConstants.searching,
                        style: getMediumStyle(
                          context: context,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : products.isEmpty
                  ? Center(
                      child: Text(
                        controller.text.isEmpty
                            ? HomeConstants.searchHint
                            : HomeConstants.notFound,
                        style: getMediumStyle(
                          context: context,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: .72,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemCount: products.length,
                      itemBuilder: (_, index) {
                        return ProductWidget(product: products[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
