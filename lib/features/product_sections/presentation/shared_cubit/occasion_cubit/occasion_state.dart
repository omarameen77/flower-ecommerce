part of 'occasion_cubit.dart';

class OccasionState extends Equatable {
  final BaseState<List<OccasionEntity>> occasionBaseState;

  const OccasionState({
    this.occasionBaseState = const BaseState(isLoading: true, data: []),
  });

  OccasionState copyWith({BaseState<List<OccasionEntity>>? occasionBaseState}) {
    return OccasionState(
      occasionBaseState: occasionBaseState ?? this.occasionBaseState,
    );
  }

  @override
  List<Object?> get props => [occasionBaseState];
}

