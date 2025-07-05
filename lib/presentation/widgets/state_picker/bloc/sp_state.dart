part of 'sp_bloc.dart';

class SpPageState {}

class SpPageInitial extends SpPageState {}

class SpPageLoading extends SpPageState {}

class SpPageLoaded extends SpPageState {
  SpPageLoaded({required this.categList});

  final List categList;
}

class SpPageLoadingFailure extends SpPageState {
  SpPageLoadingFailure({required this.exception});

  final Object? exception;
}

class SearchLoading extends SpPageState {}

class SearchLoaded extends SpPageState {
  SearchLoaded({required this.categList});

  final List categList;
}

class SearchFailure extends SpPageState {
  SearchFailure({required this.exception});

  final Object? exception;
}