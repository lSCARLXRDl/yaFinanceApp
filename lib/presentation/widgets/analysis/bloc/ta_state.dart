part of 'ta_bloc.dart';

class TaState {}

class TaInitial extends TaState {}

class TaLoaded extends TaState {
  TaLoaded({required this.transList, required this.categList, required this.totalAmount});

  final List transList;
  final List categList;
  final double totalAmount;
}

class DatePicked extends TaState {
  DatePicked({this.startDate, this.endDate});

  final String? startDate;
  final String? endDate;
}
