part of 'histo_bloc.dart';

class HistoState {}

class HistoInitial extends HistoState {}

class HistoLoading extends HistoState {}

class HistogramLoaded extends HistoState {
  HistogramLoaded({required this.listBalance});

  final Map<String, double> listBalance;
}

class HistoLoadingFailure extends HistoState {
  HistoLoadingFailure({required this.exception});

  final Object? exception;
}

