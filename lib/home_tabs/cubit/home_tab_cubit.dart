import 'package:bloc/bloc.dart';

class HomeTabCubit extends Cubit<int> {
  HomeTabCubit() : super(0);

  static const tabCounts = 3;

  void tabChanged(int position) {
    emit(position);
  }
}
