import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_counter_example/home_tabs/cubit/home_tab_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeTabCubit', () {
    test('initial state is 0', () {
      expect(HomeTabCubit().state, equals(0));
    });

    blocTest<HomeTabCubit, int>(
      'emits [1] when increment is called',
      build: HomeTabCubit.new,
      act: (cubit) => cubit.tabChanged(1),
      expect: () => [equals(1)],
    );

    blocTest<HomeTabCubit, int>(
      'emits [2] when decrement is called',
      build: HomeTabCubit.new,
      act: (cubit) => cubit.tabChanged(2),
      expect: () => [equals(2)],
    );
  });
}
