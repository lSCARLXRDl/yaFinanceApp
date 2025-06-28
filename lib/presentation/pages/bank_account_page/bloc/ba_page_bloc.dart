import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ya_finance_app/data/repositories_impl/bank_account_mock.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../data/database/account_db.dart';


part 'ba_page_event.dart';

part 'ba_page_state.dart';

class BaPageBloc extends Bloc<BaPageEvent, BaPageState> {
  BaPageBloc(this.account_repo, this.db_account_repo) : super(BaPageInitial()) {
    on<LoadAccountEvent>(_load);
  }

  final MockBankAccountRepository account_repo;
  final DBAccountRepository db_account_repo;

  Future<bool> hasRealInternet() async {
    try {
      final socket = await Socket.connect('8.8.8.8', 53, timeout: const Duration(seconds: 2));
      await socket.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _load(LoadAccountEvent event, Emitter<BaPageState> emit) async {
    try {
      if (state is! BaPageLoaded) {
        emit(BaPageLoading());
      }
      if (await hasRealInternet()) {
        final account = await account_repo.getBankAccount();
        db_account_repo.updateBankAccount(balance: account.balance, currency: account.currency, name: account.name);
      }

      final account = await db_account_repo.getBankAccount();
      emit(BaPageLoaded(balance: account['balance'], currency: account['currency'], account_name: account['account_name']));
    } catch (e) {
      emit(BaPageLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}
