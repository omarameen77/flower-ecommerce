import 'package:equatable/equatable.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class GetCategoriesEvent extends CategoriesEvent {}

class ChangeSelectedCategoryEvent extends CategoriesEvent {
  final int selectedIndex;

  const ChangeSelectedCategoryEvent(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}
