part of 'ta_bloc.dart';

class TaEvent {}

class InitExpensesEvent extends TaEvent {
  final DateTime startDate;
  final DateTime endDate;
  InitExpensesEvent(this.startDate, this.endDate,);
}

class InitIncomeEvent extends TaEvent {
  final DateTime startDate;
  final DateTime endDate;
  InitIncomeEvent(this.startDate, this.endDate,);
}

class StartDatePick extends TaEvent {
  final DateTime startDate;
  StartDatePick(this.startDate);
}

class EndDatePick extends TaEvent {
  final DateTime endDate;
  EndDatePick(this.endDate);
}