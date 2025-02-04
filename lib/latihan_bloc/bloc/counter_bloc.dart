import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(counterValue: 0)) {
    // Menangani event Increment
    on<IncrementEvent>((event, emit) {
      emit(CounterState(counterValue: state.counterValue + 1));
    });

    // Menangani event Decrement
    on<DecrementEvent>((event, emit) {
      emit(CounterState(counterValue: state.counterValue - 1));
    });
  }
}
