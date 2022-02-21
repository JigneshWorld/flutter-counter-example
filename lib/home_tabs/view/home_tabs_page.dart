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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeTabCubit()),
        BlocProvider<Counter1Bloc>(
          create: (_) => CounterBloc(
            key: 'counter1',
            counterRepository: context.read(),
          ),
        ),
        BlocProvider<Counter2Bloc>(
          create: (_) => CounterBloc(
            key: 'counter2',
            counterRepository: context.read(),
          ),
        ),
        BlocProvider<Counter3Bloc>(
          create: (_) => CounterBloc(
            key: 'counter3',
            counterRepository: context.read(),
          ),
        ),
      ],
      child: const HomeTabsView(),
    );
  }
}

class HomeTabsView extends StatelessWidget {
  const HomeTabsView({Key? key}) : super(key: key);

  Bloc<CounterEvent, int> _currentCounterBloc(BuildContext context) {
    switch (context.read<HomeTabCubit>().state) {
      case HomeTab.counter1:
        return context.read<Counter1Bloc>();
      case HomeTab.counter2:
        return context.read<Counter2Bloc>();
      case HomeTab.counter3:
        return context.read<Counter3Bloc>();
    }
  }

  void _onCounterAction(BuildContext context, CounterEvent event) {
    return _currentCounterBloc(context).add(event);
  }

  void _onReset(BuildContext context) {
    context.read<Counter1Bloc>().add(ResetCounterEvent());
    context.read<Counter2Bloc>().add(ResetCounterEvent());
    context.read<Counter3Bloc>().add(ResetCounterEvent());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.counterAppBarTitle),
        actions: [
          IconButton(
            onPressed: () => _onReset(context),
            icon: const Icon(Icons.restore),
          )
        ],
      ),
      body: IndexedStack(
        index: context.select((HomeTabCubit cubit) => cubit.state.index),
        children: const [
          CounterView<Counter1Bloc>(
            tab: HomeTab.counter1,
          ),
          CounterView<Counter2Bloc>(
            tab: HomeTab.counter2,
          ),
          CounterView<Counter3Bloc>(
            tab: HomeTab.counter3,
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _onCounterAction(context, IncrementCounterEvent()),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => _onCounterAction(context, DecrementCounterEvent()),
            child: const Icon(Icons.remove),
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
