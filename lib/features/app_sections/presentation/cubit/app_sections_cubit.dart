import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'app_sections_state.dart';

@injectable
class AppSectionsCubit extends Cubit<AppSectionsState> {
  AppSectionsCubit() : super(AppSectionsInitial());

  void changeSection(int index) {
    emit(AppSectionsChanged(currentIndex: index));
  }
}
