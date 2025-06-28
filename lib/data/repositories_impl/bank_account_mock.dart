import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ya_finance_app/data/mappers/account_map.dart';
import 'package:ya_finance_app/data/mappers/account_response_map.dart';
import 'package:ya_finance_app/data/models/response/account_response.dart';
import 'package:ya_finance_app/data/models/shared/account.dart';
import 'package:ya_finance_app/domain/models/account_response.dart';
import 'package:ya_finance_app/utils/list.dart';

import '../../domain/models/bank_account.dart';
import '../../domain/repositories/bank_account.dart';
import '../models/request/account_update_request.dart';
import 'categories_mock.dart';

class MockBankAccountRepository implements BankAccountRepository {

  final List<AccountDto> _bank_acc = [
    AccountDto(id: 1, userid: 1, name: 'Основной счёт', balance: '65012.00',
  currency: '₽', createdAt: DateTime(2024, 9, 18, 18, 29),
  updatedAt: DateTime(2024, 9, 18, 18, 29))
  ];

  @override
  Future<BankAccount> getBankAccount() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return AccountMapper.fromDto(_bank_acc[0]);
  }

  Future<AccountResponse> getBankAccountreal() async {
    final apiKey = dotenv.env['API_KEY'];
    try {
      final response = await dio.get(
        'https://shmr-finance.ru/api/v1/accounts/3',
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );
      final data = response.data;
      //final cat = AccountResponseDto.fromJson(data);
      //print(cat);
      return AccountResponseMapper.fromDto(data);
      //print(1);
      //return AccountResponse(id: data.id, name: data.name, balance: data.balance, currency: data.currency, incomeStats: data.incomeStats, expenseStats: data.expenseStats, createdAt: data.createdAt, updatedAt: data.updatedAt);
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  @override
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