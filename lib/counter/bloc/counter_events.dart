part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();
  @override
  List<Object?> get props => [];
}

class IncrementCounterEvent extends CounterEvent {}

class DecrementCounterEvent extends CounterEvent {}

class OnValueCounterEvent extends CounterEvent {
  const OnValueCounterEvent(this.value);

  final int value;

  @override
  List<Object?> get props => [...super.props, value];
}

class ResetCounterEvent extends CounterEvent {}
