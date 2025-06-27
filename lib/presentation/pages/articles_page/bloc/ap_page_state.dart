part of 'ap_page_bloc.dart';

class ApPageState {}

class ApPageInitial extends ApPageState {}

class ApPageLoading extends ApPageState {}

class ApPageLoaded extends ApPageState {
  ApPageLoaded({required this.categList});

  final List categList;
}

class ApPageLoadingFailure extends ApPageState {
  ApPageLoadingFailure({required this.exception});

  final Object? exception;
}

class SearchLoading extends ApPageState {}

class SearchLoaded extends ApPageState {
  SearchLoaded({required this.categList});

  final List categList;
}

class SearchFailure extends ApPageState {
  SearchFailure({required this.exception});

  final Object? exception;
}
