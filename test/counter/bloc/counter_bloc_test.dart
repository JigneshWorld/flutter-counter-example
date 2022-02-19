// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_counter_example/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterBloc', () {
    test('initial state is 0', () {
      expect(CounterBloc().state, equals(0));
    });

    blocTest<CounterBloc, int>(
      'emits [1] when increment is called',
      build: CounterBloc.new,
      act: (bloc) => bloc.add(CounterEvent.increment),
      expect: () => [equals(1)],
    );

    blocTest<CounterBloc, int>(
      'emits [-1] when decrement is called',
      build: CounterBloc.new,
      act: (bloc) => bloc.add(CounterEvent.decrement),
      expect: () => [equals(-1)],
    );
  });
}
