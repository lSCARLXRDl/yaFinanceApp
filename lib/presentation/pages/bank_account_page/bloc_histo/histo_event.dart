part of 'histo_bloc.dart';

class HistoEvent {}

class LoadHistogram extends HistoEvent {
  LoadHistogram({
    required this.type,
  });

  final String type;
}