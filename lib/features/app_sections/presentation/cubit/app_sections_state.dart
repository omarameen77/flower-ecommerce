part of 'app_sections_cubit.dart';

abstract class AppSectionsState {
  const AppSectionsState();
}

class AppSectionsInitial extends AppSectionsState {}

class AppSectionsChanged extends AppSectionsState {
  final int index;
  const AppSectionsChanged(this.index);
}
