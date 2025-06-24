import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ya_finance_app/data/repositories_impl/bank_account_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_mock.dart';

part 'ba_page_event.dart';

part 'ba_page_state.dart';

class BaPageBloc extends Bloc<BaPageEvent, BaPageState> {
  BaPageBloc(this.account_repo) : super(BaPageInitial()) {
    on<LoadAccountEvent>(_load);
  }

  final MockBankAccountRepository account_repo;

  Future<void> _load(LoadAccountEvent event, Emitter<BaPageState> emit) async {
    try {
      if (state is! BaPageLoaded) {
        emit(BaPageLoading());
      }
      // TODO
      emit(BaPageLoaded(balance: 3000.12, currency: "RUB"));
    } catch (e) {
      emit(BaPageLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}
