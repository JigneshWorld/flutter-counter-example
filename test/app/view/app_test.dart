// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:counter_repository/counter_repository.dart';
import 'package:flutter_counter_example/app/app.dart';
import 'package:flutter_counter_example/home_tabs/home_tab.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCounterRepository extends Mock implements CounterRepository {}

void main() {
  group('App', () {
    late CounterRepository counterRepository;

    setUp(() {
      counterRepository = MockCounterRepository();
      when(() => counterRepository.onValue(any()))
          .thenAnswer((_) => const Stream.empty());
    });

    testWidgets('renders HomeTabsPage', (tester) async {
      await tester.pumpWidget(App(counterRepository: counterRepository));
      expect(find.byType(HomeTabsPage), findsOneWidget);
    });
  });
}
