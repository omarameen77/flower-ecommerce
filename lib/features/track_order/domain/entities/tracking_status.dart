enum TrackingStatus {
  inProgress,
  picked,
  outForDelivery,
  arrived,
  completed;

  static TrackingStatus? fromString(String? value) {
    if (value == null) return null;
    return TrackingStatus.values.firstWhere(
      (s) => s.name == value,
      orElse: () => TrackingStatus.inProgress,
    );
  }

  bool get isDelivered => this == TrackingStatus.completed;
  bool get isArrived => this == TrackingStatus.arrived;
  bool get isCompleted => this == TrackingStatus.completed;
}
