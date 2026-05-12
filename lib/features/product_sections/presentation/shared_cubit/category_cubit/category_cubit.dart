import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/product_sections/domain/entities/category_entity.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/category_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'category_state.dart';

@lazySingleton
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryState());

  void doEvent(CategoryEvent event) {
    switch (event) {
      case GetCategoriesEvent():
        emit(state.copyWith(
          categoryBaseState: const BaseState(data: []),
        ));
        break;
    }
  }
}
