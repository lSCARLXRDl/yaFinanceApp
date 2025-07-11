import '../../data/models/request/account_create_request.dart';
import '../../data/models/request/account_update_request.dart';
import '../models/account_history_response.dart';
import '../models/account_response.dart';
import '../models/bank_account.dart';

abstract interface class BankAccountRepository {


  Future<BankAccount> getBankAccountById();

  Future<List<BankAccount>> getBankAccounts();

  Future<BankAccount> createBankAccount({
    required AccountCreateRequestDto request,
  });

  Future<BankAccount> updateBankAccount({
    required int id,
    required AccountUpdateRequestDto request,
  });

  Future<bool> deleteBankAccount({
    required int id,
  });

  Future<AccountHistoryResponse> getHistoryBankAccount({
    required int id,
  });
}
