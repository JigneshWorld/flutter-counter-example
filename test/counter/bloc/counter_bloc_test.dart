// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:counter_repository/counter_repository.dart';
import 'package:flutter_counter_example/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

void main() {
  group('CounterBloc', () {
    late CounterRepository counterRepository;
    const key = 'counter';

    setUp(() {
      counterRepository = MockCounterRepository();
      when(() => counterRepository.onValue(key))
          .thenAnswer((_) => const Stream.empty());
    });

    test('initial state is 0', () {
      expect(
        CounterBloc(key: key, counterRepository: counterRepository).state,
        equals(0),
      );
    });

    blocTest<CounterBloc, int>(
      'calls [counterRepo.set(1)] when increment is called',
      setUp: () {
        when(() => counterRepository.set(key, 1))
            .thenAnswer((_) => Future.value());
      },
      build: () => CounterBloc(key: key, counterRepository: counterRepository),
      act: (bloc) => bloc.add(IncrementCounterEvent()),
      verify: (bloc) {
        verify(() => counterRepository.set(key, 1)).called(1);
      },
    );

    blocTest<CounterBloc, int>(
      'calls [counterRepo.set(-1)] when decrement is called',
      setUp: () {
        when(() => counterRepository.set(key, -1))
            .thenAnswer((_) => Future.value());
      },
      build: () => CounterBloc(key: key, counterRepository: counterRepository),
      act: (bloc) => bloc.add(DecrementCounterEvent()),
      verify: (bloc) {
        verify(() => counterRepository.set(key, -1)).called(1);
      },
    );

    blocTest<CounterBloc, int>(
      'emits [5] when counterRepo.onValue emits [5]',
      setUp: () {
        when(() => counterRepository.onValue(key))
            .thenAnswer((_) => Stream.fromIterable([5]));
      },
      build: () => CounterBloc(key: key, counterRepository: counterRepository),
      expect: () => [equals(5)],
      verify: (bloc) {
        verify(() => counterRepository.onValue(key)).called(1);
      },
    );

    blocTest<CounterBloc, int>(
      'calls [counterRepo.set(0)] when reset is called',
      setUp: () {
        when(() => counterRepository.set(key, 0))
            .thenAnswer((_) => Future.value());
      },
      build: () => CounterBloc(key: key, counterRepository: counterRepository),
      act: (bloc) => bloc.add(ResetCounterEvent()),
      verify: (bloc) {
        verify(() => counterRepository.set(key, 0)).called(1);
      },
    );
  });
}
