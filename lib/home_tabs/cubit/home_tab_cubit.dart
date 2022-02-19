import 'package:bloc/bloc.dart';
import 'package:flutter_counter_example/home_tabs/models/home_tab.dart';

class HomeTabCubit extends Cubit<HomeTab> {
  HomeTabCubit() : super(HomeTab.counter1);

  void tabChanged(HomeTab newTab) {
    emit(newTab);
  }
}
