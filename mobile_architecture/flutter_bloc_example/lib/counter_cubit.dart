import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  int state;
  CounterCubit() : state = 0, super(0);

  void increment() {
    state++;
    emit(state);
  }

  void decrement() {
    state--;
    emit(state);
  }
}
