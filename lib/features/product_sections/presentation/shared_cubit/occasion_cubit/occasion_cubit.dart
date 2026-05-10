import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/domain/entities/occasion_entity.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_occasion_use_case.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/occasion_cubit/occasion_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'occasion_state.dart';

@lazySingleton
class OccasionCubit extends Cubit<OccasionState> {
  final GetOccasionUseCase getOccasionUseCase;

  OccasionCubit({required this.getOccasionUseCase}) : super(const OccasionState());

  void doEvent(OccasionEvent event) {
    switch (event) {
      case GetOccasionsEvent():
        _getOccasions();
        break;
    }
  }


  Future<void> _getOccasions() async {
    try {
      emit(
        state.copyWith(
          occasionBaseState: const BaseState(isLoading: true, data: []),
        ),
      );

      final result = await getOccasionUseCase.call();
      switch (result) {
        case SuccessBaseResponse<List<OccasionEntity>>():
          emit(
            state.copyWith(
              occasionBaseState: BaseState(data: result.data),
            ),
          );
        case ErrorBaseResponse<List<OccasionEntity>>():
          emit(
            state.copyWith(
              occasionBaseState: BaseState(
                data: const [],
                errorMessage: result.failure.message,
              ),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          occasionBaseState: BaseState(
            data: const [],
            errorMessage: ErrorHandler.handle(e).message,
          ),
        ),
      );
    }
  }
}
