part of 'sp_bloc.dart';

class SpPageEvent {}

class LoadStatesEvent extends SpPageEvent {
  LoadStatesEvent({this.completer, required this.isIncome});

  final Completer? completer;
  final bool isIncome;
}

class SearchStatesEvent extends SpPageEvent {
  SearchStatesEvent({required this.searchStr, required this.isIncome, this.completer});

  final Completer? completer;
  final String searchStr;
  final bool isIncome;
}
