// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_example/counter/counter.dart';
import 'package:flutter_counter_example/home_tabs/models/home_tab.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockCounterBloc extends MockBloc<CounterEvent, int>
    implements CounterBloc {}

void main() {
  // group('CounterView', () {
  //   testWidgets('renders CounterView', (tester) async {
  //     await tester.pumpApp(const CounterPage(tab: HomeTab.counter1));
  //     expect(find.byType(CounterView), findsOneWidget);
  //   });
  // });

  group('CounterView', () {
    late CounterBloc counterBloc;

    setUp(() {
      counterBloc = MockCounterBloc();
    });

    testWidgets('renders current count', (tester) async {
      const state = 42;
      when(() => counterBloc.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: counterBloc,
          child: const CounterView<CounterBloc>(tab: HomeTab.counter1),
        ),
      );
      expect(find.text('$state'), findsOneWidget);
    });

    // testWidgets('calls increment when increment button is tapped',
    //     (tester) async {
    //   when(() => counterCubit.state).thenReturn(0);
    //   when(() => counterCubit.add(CounterEvent.increment)).thenReturn(null);
    //   await tester.pumpApp(
    //     BlocProvider.value(
    //       value: counterCubit,
    //       child: const CounterView<CounterBloc>(tab: HomeTab.counter1),
    //     ),
    //   );
    //   await tester.tap(find.byIcon(Icons.add));
    //   verify(() => counterCubit.add(CounterEvent.increment)).called(1);
    // });

    // testWidgets('calls decrement when decrement button is tapped',
    //     (tester) async {
    //   when(() => counterCubit.state).thenReturn(0);
    //   when(() => counterCubit.add(CounterEvent.decrement)).thenReturn(null);
    //   await tester.pumpApp(
    //     BlocProvider.value(
    //       value: counterCubit,
    //       child: const CounterView<CounterBloc>(tab: HomeTab.counter1),
    //     ),
    //   );
    //   await tester.tap(find.byIcon(Icons.remove));
    //   verify(() => counterCubit.add(CounterEvent.decrement)).called(1);
    // });
  });
}
