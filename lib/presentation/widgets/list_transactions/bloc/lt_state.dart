part of 'lt_bloc.dart';

class LtState {}

class LtInitial extends LtState {}

class LtLoaded extends LtState {
  LtLoaded({required this.transList, required this.categList, required this.totalAmount, required this.isIncome});

  final List transList;
  final List categList;
  final double totalAmount;
  final bool isIncome;
}
