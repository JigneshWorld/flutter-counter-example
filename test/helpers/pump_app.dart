// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:counter_repository/counter_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_example/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../app/view/app_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    CounterRepository? counterRepository,
  }) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<CounterRepository>.value(
            value: counterRepository ?? MockCounterRepository(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }
}
