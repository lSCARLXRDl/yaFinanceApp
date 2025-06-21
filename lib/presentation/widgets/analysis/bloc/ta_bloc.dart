import 'package:bloc/bloc.dart';

part 'ta_event.dart';
part 'ta_state.dart';

class TaBloc extends Bloc<TaEvent, TaState> {
  TaBloc() : super(const TaInitial(0)) {
    on<IncrementEvent>((event, emit) {
      emit(TaInitial(state.value + 1));
    });

    on<DecrementEvent>((event, emit) {
      emit(TaInitial(state.value - 1));
    });
  }
}