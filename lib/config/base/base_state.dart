import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final bool isLoading;
  final T? data;
  final String? errorMessage;

  const BaseState({this.isLoading = false, this.data, this.errorMessage});

  BaseState<T> copyWith({
    bool? isLoadingParam,
    T? dataParam,
    String? errorMessageParam,
  }) {
    return BaseState<T>(
      isLoading: isLoadingParam ?? isLoading,
      data: dataParam ?? data,
      errorMessage: errorMessageParam ?? errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, data, errorMessage];
}
