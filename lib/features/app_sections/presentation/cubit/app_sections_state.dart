part of 'app_sections_cubit.dart';

abstract class AppSectionsState extends Equatable {
  const AppSectionsState();
}

class AppSectionsInitial extends AppSectionsState {
  @override
  List<Object?> get props => [];
}

class AppSectionsChanged extends AppSectionsState {
  final int currentIndex;

  const AppSectionsChanged({this.currentIndex = 0});

  @override
  List<Object?> get props => [currentIndex];
}
