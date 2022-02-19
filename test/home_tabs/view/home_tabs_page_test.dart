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

class MockCounterBloc extends MockBloc<CounterEvent, int>
    implements CounterBloc {}

void main() {
  group('HomeTabsPage', () {
    testWidgets('renders HomeTabsView', (tester) async {
      await tester.pumpApp(const HomeTabsPage());
      expect(find.byType(HomeTabsView), findsOneWidget);
    });
  });

  group('HomeTabsView', () {
    late HomeTabCubit homeTabsCubit;
    late CounterBloc counter1Bloc, counter2Bloc, counter3Bloc;
    late Widget widget;

    setUp(() {
      homeTabsCubit = MockHomeTabCubit();
      when(() => homeTabsCubit.state).thenReturn(HomeTab.counter1);
      counter1Bloc = MockCounterBloc();
      when(() => counter1Bloc.state).thenReturn(0);
      counter2Bloc = MockCounterBloc();
      when(() => counter2Bloc.state).thenReturn(0);
      counter3Bloc = MockCounterBloc();
      when(() => counter3Bloc.state).thenReturn(0);
      widget = MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: homeTabsCubit,
          ),
          BlocProvider<Counter1Bloc>.value(
            value: counter1Bloc,
          ),
          BlocProvider<Counter2Bloc>.value(
            value: counter2Bloc,
          ),
          BlocProvider<Counter3Bloc>.value(
            value: counter3Bloc,
          ),
        ],
        child: const HomeTabsView(),
      );
    });

    testWidgets('renders bottom navigation bar with counter labels',
        (tester) async {
      await tester.pumpApp(widget);
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
      await tester.pumpApp(widget);

      await tester.tap(find.widgetWithText(BottomNavigationBar, 'Counter 2'));

      verify(() => homeTabsCubit.tabChanged(HomeTab.counter2)).called(1);
    });

    testWidgets(
      'renders CounterView 1 with subtitle',
      (tester) => _renderCounterView(
          tester, widget, CounterView<Counter1Bloc>, 'Counter 1'),
    );

    testWidgets(
      'renders CounterView 2 with subtitle',
      (tester) => _renderCounterView(
          tester, widget, CounterView<Counter2Bloc>, 'Counter 2'),
    );

    testWidgets(
      'renders CounterView 3 with subtitle',
      (tester) => _renderCounterView(
          tester, widget, CounterView<Counter3Bloc>, 'Counter 3'),
    );
  });
}

Future<void> _renderCounterView(
  WidgetTester tester,
  Widget widget,
  Type widgetType,
  String title,
) async {
  await tester.pumpApp(widget);
  expect(
    find.widgetWithText(widgetType, title),
    findsOneWidget,
  );
}
