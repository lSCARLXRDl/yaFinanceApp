part of 'ta_bloc.dart';

abstract class TaEvent {
  const TaEvent();

  @override
  List<Object> get props => [];
}

class IncrementEvent extends TaEvent {}
class DecrementEvent extends TaEvent {}