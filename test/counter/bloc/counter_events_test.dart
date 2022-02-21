// ignore_for_file: prefer_const_constructors

import 'package:flutter_counter_example/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterEvent', () {
    test('description', () {
      expect(OnValueCounterEvent(1), OnValueCounterEvent(1));
    });
  });
}
