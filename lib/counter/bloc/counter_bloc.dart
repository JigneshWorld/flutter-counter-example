// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }

mixin Counter1Bloc on Bloc<CounterEvent, int> {}

mixin Counter2Bloc on Bloc<CounterEvent, int> {}

mixin Counter3Bloc on Bloc<CounterEvent, int> {}

class CounterBloc extends Bloc<CounterEvent, int>
    with Counter1Bloc, Counter2Bloc, Counter3Bloc {
  CounterBloc() : super(0) {
    on<CounterEvent>(_onCounterEvent);
  }

  void _onCounterEvent(CounterEvent event, Emitter<int> emit) {
    switch (event) {
      case CounterEvent.increment:
        emit(state + 1);
        break;
      case CounterEvent.decrement:
        emit(state - 1);
        break;
    }
  }
}
