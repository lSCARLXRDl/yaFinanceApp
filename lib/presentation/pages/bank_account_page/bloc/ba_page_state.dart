part of 'ba_page_bloc.dart';

class BaPageState {}

class BaPageInitial extends BaPageState {}

class BaPageLoading extends BaPageState {}

class BaPageLoaded extends BaPageState {
  BaPageLoaded({required this.balance, required this.currency, required this.account_name});

  final String balance;
  final String currency;
  final String account_name;
}

class BaPageLoadingFailure extends BaPageState {
  BaPageLoadingFailure({required this.exception});

  final Object? exception;
}
