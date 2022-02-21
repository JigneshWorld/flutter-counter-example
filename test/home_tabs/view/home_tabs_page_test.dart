import 'package:bloc_test/bloc_test.dart';
import 'package:counter_repository/counter_repository.dart';
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
  late CounterRepository counterRepository;

  setUp(() {
    counterRepository = MockCounterRepository();
    when(() => counterRepository.onValue(any()))
        .thenAnswer((_) => const Stream.empty());
  });

  group('HomeTabsPage', () {
    testWidgets('renders HomeTabsView', (tester) async {
      await tester.pumpApp(
        const HomeTabsPage(),
        counterRepository: counterRepository,
      );
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

    testWidgets('renders CounterView 1 with subtitle', (tester) async {
      await tester.pumpApp(widget);
      expect(
        find.widgetWithText(CounterView<Counter1Bloc>, 'Counter 1'),
        findsOneWidget,
      );
    });

    testWidgets('calls reset on every counter bloc when reset button is tapped',
        (tester) async {
      await tester.pumpApp(widget);
      await tester.tap(find.byIcon(Icons.restore));
      verify(() => counter1Bloc.add(ResetCounterEvent())).called(1);
      verify(() => counter2Bloc.add(ResetCounterEvent())).called(1);
      verify(() => counter3Bloc.add(ResetCounterEvent())).called(1);
    });

    testWidgets(
        'CounterView 1: calls increment when increment button is tapped',
        (tester) async {
      when(() => counter1Bloc.state).thenReturn(0);
      when(() => counter1Bloc.add(IncrementCounterEvent())).thenReturn(null);
      await tester.pumpApp(widget);
      await tester.tap(find.byIcon(Icons.add));
      verify(() => counter1Bloc.add(IncrementCounterEvent())).called(1);
    });

    testWidgets(
        'CounterView 2: calls decrement when decrement button is tapped',
        (tester) async {
      when(() => homeTabsCubit.state).thenReturn(HomeTab.counter2);
      when(() => counter2Bloc.state).thenReturn(0);
      when(() => counter2Bloc.add(DecrementCounterEvent())).thenReturn(null);
      await tester.pumpApp(widget);
      await tester.tap(find.byIcon(Icons.remove));
      verify(() => counter2Bloc.add(DecrementCounterEvent())).called(1);
    });

    testWidgets(
        'CounterView 3: calls decrement when decrement button is tapped',
        (tester) async {
      when(() => homeTabsCubit.state).thenReturn(HomeTab.counter3);
      when(() => counter3Bloc.state).thenReturn(0);
      when(() => counter3Bloc.add(DecrementCounterEvent())).thenReturn(null);
      await tester.pumpApp(widget);
      await tester.tap(find.byIcon(Icons.remove));
      verify(() => counter3Bloc.add(DecrementCounterEvent())).called(1);
    });

    testWidgets('calls tabChanged when Counter 2 tab pressed', (tester) async {
      await tester.pumpApp(widget);

      await tester.tap(find.widgetWithText(BottomNavigationBar, 'Counter 2'));

      verify(() => homeTabsCubit.tabChanged(HomeTab.counter2)).called(1);
    });

    testWidgets('renders CounterView 2 with subtitle', (tester) async {
      await tester.pumpApp(widget);
      expect(
        find.widgetWithText(CounterView<Counter2Bloc>, 'Counter 2'),
        findsOneWidget,
      );
    });

    testWidgets('renders CounterView 3 with subtitle', (tester) async {
      await tester.pumpApp(widget);
      expect(
        find.widgetWithText(CounterView<Counter3Bloc>, 'Counter 3'),
        findsOneWidget,
      );
    });
  });
}
