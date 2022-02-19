import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_example/counter/counter.dart';
import 'package:flutter_counter_example/home_tabs/cubit/home_tab_cubit.dart';
import 'package:flutter_counter_example/home_tabs/home_tab.dart';
import 'package:flutter_counter_example/home_tabs/models/home_tab.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockHomeTabCubit extends MockCubit<HomeTab> implements HomeTabCubit {}

void main() {
  group('HomeTabsPage', () {
    testWidgets('renders HomeTabsView', (tester) async {
      await tester.pumpApp(const HomeTabsPage());
      expect(find.byType(HomeTabsView), findsOneWidget);
    });
  });

  group('HomeTabsView', () {
    late HomeTabCubit homeTabsCubit;

    setUp(() {
      homeTabsCubit = MockHomeTabCubit();
    });

    testWidgets('renders bottom navigation bar with counter labels',
        (tester) async {
      const state = HomeTab.counter1;
      when(() => homeTabsCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: homeTabsCubit,
          child: const HomeTabsView(),
        ),
      );
      expect(
        find.widgetWithText(BottomNavigationBar, 'Counter 1'),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(BottomNavigationBar, 'Counter 2'),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(BottomNavigationBar, 'Counter 3'),
        findsOneWidget,
      );
    });

    testWidgets('calls tabChanged when Counter 2 tab pressed', (tester) async {
      when(() => homeTabsCubit.state).thenReturn(HomeTab.counter1);
      await tester.pumpApp(
        BlocProvider.value(
          value: homeTabsCubit,
          child: const HomeTabsView(),
        ),
      );

      await tester.tap(find.widgetWithText(BottomNavigationBar, 'Counter 2'));

      verify(() => homeTabsCubit.tabChanged(HomeTab.counter2)).called(1);
    });

    testWidgets(
      'renders CounterView 1 with subtitle',
      (tester) => _renderCounterView(tester, homeTabsCubit, 0),
    );

    testWidgets(
      'renders CounterView 2 with subtitle',
      (tester) => _renderCounterView(tester, homeTabsCubit, 1),
    );

    testWidgets(
      'renders CounterView 3 with subtitle',
      (tester) => _renderCounterView(tester, homeTabsCubit, 2),
    );
  });
}

Future<void> _renderCounterView(
  WidgetTester tester,
  HomeTabCubit cubit,
  int index,
) async {
  const state = HomeTab.counter1;
  when(() => cubit.state).thenReturn(state);
  await tester.pumpApp(
    BlocProvider.value(
      value: cubit,
      child: const HomeTabsView(),
    ),
  );
  expect(
    find.widgetWithText(CounterView, 'Counter ${state.index + 1}'),
    findsOneWidget,
  );
}
