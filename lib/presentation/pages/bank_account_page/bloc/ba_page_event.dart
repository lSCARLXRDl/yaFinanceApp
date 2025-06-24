part of 'ba_page_bloc.dart';

class BaPageEvent {}

class LoadAccountEvent extends BaPageEvent {
  LoadAccountEvent({
    this.completer,
  });

  final Completer? completer;
}