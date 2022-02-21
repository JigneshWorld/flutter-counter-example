// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_example/counter/counter.dart';
import 'package:flutter_counter_example/home_tabs/models/home_tab.dart';
import 'package:flutter_counter_example/l10n/l10n.dart';

class CounterView<T extends Bloc<CounterEvent, int>> extends StatelessWidget {
  const CounterView({
    Key? key,
    required this.tab,
  }) : super(key: key);

  final HomeTab tab;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(l10n.counterTabTitle(tab.index + 1)),
      ),
      body: Center(child: CounterText<T>()),
    );
  }
}

class CounterText<T extends Bloc<CounterEvent, int>> extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((T bloc) => bloc.state);
    return Text('$count', style: theme.textTheme.headline1);
  }
}
