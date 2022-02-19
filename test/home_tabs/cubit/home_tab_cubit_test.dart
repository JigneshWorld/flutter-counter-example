import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_counter_example/home_tabs/cubit/home_tab_cubit.dart';
import 'package:flutter_counter_example/home_tabs/models/home_tab.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeTabCubit', () {
    test('initial state is HomeTab.counter1', () {
      expect(HomeTabCubit().state, equals(HomeTab.counter1));
    });

    blocTest<HomeTabCubit, HomeTab>(
      'emits [HomeTab.counter2] when tabChanged with counter2 called',
      build: HomeTabCubit.new,
      act: (cubit) => cubit.tabChanged(HomeTab.counter2),
      expect: () => [equals(HomeTab.counter2)],
    );

    blocTest<HomeTabCubit, HomeTab>(
      'emits [HomeTab.counter3] when tabChanged with counter3 is called',
      build: HomeTabCubit.new,
      act: (cubit) => cubit.tabChanged(HomeTab.counter3),
      expect: () => [equals(HomeTab.counter3)],
    );
  });
}
