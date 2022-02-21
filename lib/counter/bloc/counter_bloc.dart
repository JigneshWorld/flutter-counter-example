// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:counter_repository/counter_repository.dart';
import 'package:equatable/equatable.dart';

part 'counter_events.dart';

mixin Counter1Bloc on Bloc<CounterEvent, int> {}

mixin Counter2Bloc on Bloc<CounterEvent, int> {}

mixin Counter3Bloc on Bloc<CounterEvent, int> {}

class CounterBloc extends Bloc<CounterEvent, int>
    with Counter1Bloc, Counter2Bloc, Counter3Bloc {
  CounterBloc({
    required this.key,
    required this.counterRepository,
  }) : super(0) {
    _streamSub = counterRepository
        .onValue(key)
        .listen((value) => add(OnValueCounterEvent(value)));
    on<IncrementCounterEvent>(_onIncrementCounterEvent);
    on<DecrementCounterEvent>(_onDecrementCounterEvent);
    on<OnValueCounterEvent>(_onOnValueCounterEvent);
  }

  final CounterRepository counterRepository;
  final String key;
  late StreamSubscription _streamSub;

  void _onIncrementCounterEvent(
    IncrementCounterEvent event,
    Emitter<int> emit,
  ) {
    counterRepository.set(key, state + 1);
  }

  void _onDecrementCounterEvent(
    DecrementCounterEvent event,
    Emitter<int> emit,
  ) {
    counterRepository.set(key, state - 1);
  }

  void _onOnValueCounterEvent(
    OnValueCounterEvent event,
    Emitter<int> emit,
  ) {
    emit(event.value);
  }

  @override
  Future<void> close() {
    _streamSub.cancel();
    return super.close();
  }
}
