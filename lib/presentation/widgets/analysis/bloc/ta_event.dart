part of 'ta_bloc.dart';

class TaEvent {}

class InitExpensesEvent extends TaEvent {
  final DateTime startDate;
  final DateTime endDate;
  final String sortType;
  InitExpensesEvent(this.startDate, this.endDate, this.sortType);
}

class InitIncomeEvent extends TaEvent {
  final DateTime startDate;
  final DateTime endDate;
  final String sortType;
  InitIncomeEvent(this.startDate, this.endDate, this.sortType);
}

class StartDatePick extends TaEvent {
  final DateTime startDate;
  StartDatePick(this.startDate);
}

class EndDatePick extends TaEvent {
  final DateTime endDate;
  EndDatePick(this.endDate);
}