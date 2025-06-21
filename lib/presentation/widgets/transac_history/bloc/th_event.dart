part of 'th_bloc.dart';

class ThEvent {}

class InitExpensesEvent extends ThEvent {
  final DateTime startDate;
  final DateTime endDate;
  final String sortType;
  InitExpensesEvent(this.startDate, this.endDate, this.sortType);
}

class InitIncomeEvent extends ThEvent {
  final DateTime startDate;
  final DateTime endDate;
  final String sortType;
  InitIncomeEvent(this.startDate, this.endDate, this.sortType);
}

class StartDatePick extends ThEvent {
  final DateTime startDate;
  StartDatePick(this.startDate);
}

class EndDatePick extends ThEvent {
  final DateTime endDate;
  EndDatePick(this.endDate);
}