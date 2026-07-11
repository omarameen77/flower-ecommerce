import 'dart:async';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower/features/track_order/domain/usecases/confirm_delivery_use_case.dart';
import 'package:flower/features/track_order/domain/usecases/get_current_order_use_case.dart';
import 'package:flower/features/track_order/domain/usecases/save_current_order_use_case.dart';
import 'package:flower/features/track_order/domain/usecases/watch_order_state_use_case.dart';
import 'package:flower/features/track_order/presentation/cubit/track_order_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'track_order_state.dart';

@injectable
class TrackOrderCubit extends Cubit<TrackOrderState> {
  final WatchOrderStateUseCase _watchOrderStateUseCase;
  final ConfirmDeliveryUseCase _confirmDeliveryUseCase;
  final SaveCurrentOrderUseCase _saveCurrentOrderUseCase;
  final GetCurrentOrderUseCase _getCurrentOrderUseCase;
  StreamSubscription<TrackOrderEntity?>? _subscription;

  TrackOrderCubit(
    this._watchOrderStateUseCase,
    this._confirmDeliveryUseCase,
    this._saveCurrentOrderUseCase,
    this._getCurrentOrderUseCase,
  ) : super(const TrackOrderState());

  void doEvent(TrackOrderEvent event) {
    switch (event) {
      case WatchOrder():
        _watchOrder(event);
        break;

      case StopWatchingOrder():
        _stopWatching();
        break;

      case ConfirmDelivery():
        _confirmDelivery(event);
        break;
    }
  }

  Future<void> _watchOrder(WatchOrder event) async {
    await _subscription?.cancel();
    emit(state.copyWith(orderData: const BaseState(isLoading: true)));

    try {
      final existing = await _getCurrentOrderUseCase(orderId: event.orderId);
      switch (existing) {
        case SuccessBaseResponse<TrackOrderEntity?>() when existing.data == null && event.orderData != null:
          final saveResult = await _saveCurrentOrderUseCase(
            orderId: event.orderId,
            order: event.orderData!,
          );
          switch (saveResult) {
            case SuccessBaseResponse<void>():
              break;
            case ErrorBaseResponse<void>():
              emit(state.copyWith(
                orderData: BaseState(
                  errorMessage: saveResult.failure.message,
                  data: state.orderData.data,
                ),
              ));
              return;
          }
        case ErrorBaseResponse<TrackOrderEntity?>():
          emit(state.copyWith(
            orderData: BaseState(
              errorMessage: existing.failure.message,
              data: state.orderData.data,
            ),
          ));
          return;
        default:
          break;
      }

      _subscription = _watchOrderStateUseCase(orderId: event.orderId).listen(
        (order) {
          emit(state.copyWith(orderData: BaseState(data: order)));
        },
        onError: (error) {
          emit(state.copyWith(
            orderData: BaseState(
              errorMessage: error.toString(),
              data: state.orderData.data,
            ),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        orderData: BaseState(
          errorMessage: ErrorHandler.handle(e).message,
          data: state.orderData.data,
        ),
      ));
    }
  }

  Future<void> _confirmDelivery(ConfirmDelivery event) async {
    emit(state.copyWith(
      confirmDeliveryState: const BaseState(isLoading: true),
      confirmSuccess: false,
    ));

    try {
      final result = await _confirmDeliveryUseCase(orderId: event.orderId);
      switch (result) {
        case SuccessBaseResponse<void>():
          emit(state.copyWith(
            confirmDeliveryState: const BaseState(data: null),
            confirmSuccess: true,
          ));
        case ErrorBaseResponse<void>():
          emit(state.copyWith(
            confirmDeliveryState: BaseState(
              errorMessage: result.failure.message,
              data: state.confirmDeliveryState.data,
            ),
          ));
      }
    } catch (e) {
      emit(state.copyWith(
        confirmDeliveryState: BaseState(
          errorMessage: ErrorHandler.handle(e).message,
          data: state.confirmDeliveryState.data,
        ),
      ));
    }
  }

  void _stopWatching() {
    _subscription?.cancel();
    _subscription = null;
  }

  void resetConfirmSuccess() {
    emit(state.copyWith(confirmSuccess: false));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
