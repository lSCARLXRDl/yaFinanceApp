import 'package:ya_finance_app/data/mappers/account_map.dart';
import 'package:ya_finance_app/data/models/shared/account.dart';
import 'package:ya_finance_app/utils/list.dart';

import '../../domain/models/bank_account.dart';
import '../../domain/repositories/bank_account.dart';
import '../models/request/account_update_request.dart';

class MockBankAccountRepository {

  final List<AccountDto> _bank_acc = [
    AccountDto(id: 1, userId: 1, name: 'Основной счёт', balance: '65012.00',
        currency: 'RUB', createdAt: DateTime(2024, 9, 18, 18, 29),
        updatedAt: DateTime(2024, 9, 18, 18, 29))
  ];

  Future<BankAccount> getBankAccount() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return AccountMapper.fromDto(_bank_acc[0]);
  }

  Future<BankAccount> updateBankAccount({required int id, required AccountUpdateRequestDto request}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final account = _bank_acc.firstWhereOrNull((e) => e.id == id);
    if (account == null) {
      throw Exception();
    }
    _bank_acc.removeWhere((e) => e.id == id);
    final newAcc = account.copyWith(currency: request.currency, balance: request.balance, name: request.name);
    _bank_acc.add(newAcc);
    return AccountMapper.fromDto(newAcc);
  }

}