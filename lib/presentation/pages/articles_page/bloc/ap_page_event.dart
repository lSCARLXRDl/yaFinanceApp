part of 'ap_page_bloc.dart';

class ApPageEvent {}

class LoadStatesEvent extends ApPageEvent {
  LoadStatesEvent({this.completer});

  final Completer? completer;
}

class SearchStatesEvent extends ApPageEvent {
  SearchStatesEvent({required this.searchStr, this.completer});

  final Completer? completer;
  final String searchStr;
}
