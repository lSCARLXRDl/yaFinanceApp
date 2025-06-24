part of 'ba_page_bloc.dart';

class BaPageState {}

class BaPageInitial extends BaPageState {}

class BaPageLoading extends BaPageState {}

class BaPageLoaded extends BaPageState {
  BaPageLoaded({required this.balance, required this.currency});

  final double balance;
  final String currency;
}

class BaPageLoadingFailure extends BaPageState {
  BaPageLoadingFailure({required this.exception});

  final Object? exception;
}
