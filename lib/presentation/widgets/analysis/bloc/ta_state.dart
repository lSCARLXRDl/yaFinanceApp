part of 'ta_bloc.dart';

class TaState {}

class TaInitial extends TaState {}

class TaLoaded extends TaState {
  TaLoaded({required this.categListWithTransac, required this.percentList, required this.amountList, required this.totalAmount});

  final Map categListWithTransac;
  final List<String> percentList;
  final List<double> amountList;
  final double totalAmount;
}

class DatePicked extends TaState {
  DatePicked({this.startDate, this.endDate});

  final String? startDate;
  final String? endDate;
}
