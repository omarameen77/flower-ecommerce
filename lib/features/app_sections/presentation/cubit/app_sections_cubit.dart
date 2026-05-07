import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_sections_state.dart';

class AppSectionsCubit extends Cubit<AppSectionsState> {
  AppSectionsCubit() : super(AppSectionsInitial());

  int currentIndex = 0;

  void changeSection(int index) {
    if (currentIndex == index) return;
    currentIndex = index;
    emit(AppSectionsChanged(index));
  }
}
