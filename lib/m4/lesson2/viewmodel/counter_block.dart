import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4_lesson1/m4/lesson2/model/counter_model.dart';

import 'package:m4_lesson1/m4/lesson2/viewmodel/counter_event.dart';
import 'package:m4_lesson1/m4/lesson2/viewmodel/counter_state.dart';

class CounterBlock extends Bloc<CounterEvent, CounterState> {
  CounterBlock() : super(CounterState(CounterModel(count: 0, status: "Мало"))) {
    on<IncrementEvent>(_increment);
    on<DecrementEvent>(_decrement);
  }

  void _increment(CounterEvent event, Emitter<CounterState> emit) {
    final newCount = state.model.count + 1;
    print('click in bloc');
    emit(CounterState(state.model.copyWith(newCount, _getStatus(newCount))));
  }

  void _decrement(CounterEvent event, Emitter<CounterState> emit) {
    final newCount = state.model.count - 1;
    emit(CounterState(state.model.copyWith(newCount, _getStatus(newCount))));
  }

  String _getStatus(int newCount) {
    if (newCount < 0) return "Отрицательное";
    if (newCount < 5) return "Мало";
    if (newCount < 10) return "Нормально";
    
    return "Много";
  }
}
