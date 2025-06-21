part of 'th_bloc.dart';

class ThState {}

class ThInitial extends ThState {}

class ThLoaded extends ThState {
  ThLoaded({required this.transList, required this.categList, required this.totalAmount});

  final List transList;
  final List categList;
  final double totalAmount;
}

class DatePicked extends ThState {
  DatePicked({this.startDate, this.endDate});

  final String? startDate;
  final String? endDate;
}
