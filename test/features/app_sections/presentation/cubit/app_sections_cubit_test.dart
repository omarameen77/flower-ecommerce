// app_sections_cubit_test.dart

import 'package:flower/features/app_sections/presentation/cubit/app_sections_cubit.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  late AppSectionsCubit cubit;

  setUp(() {
    cubit = AppSectionsCubit();
  });

  tearDown(() async {
    await cubit.close();
  });

  test('initial state is AppSectionsInitial', () {
    expect(cubit.state, isA<AppSectionsInitial>());
  });

  test('changeSection updates currentIndex and emits AppSectionsChanged', () {
    cubit.changeSection(1);

    expect(cubit.state, isA<AppSectionsChanged>());
    expect((cubit.state as AppSectionsChanged).currentIndex, 1);
  });

  test('changeSection emits even when same index is passed', () {
    cubit.changeSection(0);

    expect(cubit.state, isA<AppSectionsChanged>());
    expect((cubit.state as AppSectionsChanged).currentIndex, 0);
  });

  test('changeSection emits correct state for multiple changes', () {
    cubit.changeSection(1);

    expect((cubit.state as AppSectionsChanged).currentIndex, 1);

    cubit.changeSection(2);

    expect((cubit.state as AppSectionsChanged).currentIndex, 2);
  });
}