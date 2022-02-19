import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_example/counter/counter.dart';
import 'package:flutter_counter_example/home_tabs/cubit/home_tab_cubit.dart';
import 'package:flutter_counter_example/home_tabs/models/home_tab.dart';
import 'package:flutter_counter_example/l10n/l10n.dart';

class HomeTabsPage extends StatelessWidget {
  const HomeTabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeTabCubit(),
      child: const HomeTabsView(),
    );
  }
}

class HomeTabsView extends StatelessWidget {
  const HomeTabsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: IndexedStack(
        index: context.select((HomeTabCubit cubit) => cubit.state.index),
        children: [
          for (var i = 0; i < HomeTab.values.length; i++)
            CounterPage(
              tab: HomeTab.values[i],
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.select((HomeTabCubit cubit) => cubit.state.index),
        onTap: (index) =>
            context.read<HomeTabCubit>().tabChanged(HomeTab.values[index]),
        items: [
          for (var i = 0; i < HomeTab.values.length; i++)
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: l10n.counterTabTitle(i + 1),
            ),
        ],
      ),
    );
  }
}
