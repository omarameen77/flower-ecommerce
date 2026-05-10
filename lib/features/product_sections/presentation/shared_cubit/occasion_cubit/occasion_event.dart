

import 'package:equatable/equatable.dart';

sealed class OccasionEvent extends Equatable {
  const OccasionEvent();

  @override
  List<Object> get props => [];
}

final class GetOccasionsEvent extends OccasionEvent {
  const GetOccasionsEvent();

  @override
  List<Object> get props => [];
}
