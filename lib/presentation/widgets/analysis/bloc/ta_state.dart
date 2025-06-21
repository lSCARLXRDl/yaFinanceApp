part of 'ta_bloc.dart';

abstract class TaState {
  final int value;
  const TaState(this.value);

  @override
  List<Object> get props => [];
}

class TaInitial extends TaState {
  final int value;

  const TaInitial(this.value) : super(0);

  @override
  List<Object> get props => [value];
}