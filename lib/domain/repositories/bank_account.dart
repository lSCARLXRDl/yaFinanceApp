import '../../data/models/request/account_update_request.dart';
import '../models/bank_account.dart';

abstract interface class BankAccountRepository {
  Future<BankAccount> updateBankAccount({
    required int id,
    required AccountUpdateRequestDto request,
  });

  Future<BankAccount> getBankAccount();
}
