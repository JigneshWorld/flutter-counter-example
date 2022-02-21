// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:counter_repository/counter_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_counter_example/app/app.dart';
import 'package:flutter_counter_example/bootstrap.dart';
import 'package:flutter_counter_example/firebase_options/staging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final counterRepository = CounterRepository();
  await bootstrap(
    () => App(
      counterRepository: counterRepository,
    ),
  );
}
