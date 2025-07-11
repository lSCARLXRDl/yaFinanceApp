import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_finance_app/data/api/api_client.dart';
import 'package:ya_finance_app/data/mappers/account_map.dart';
import 'package:ya_finance_app/data/mappers/account_response_map.dart';
import 'package:ya_finance_app/data/models/shared/account.dart';
import 'package:ya_finance_app/domain/models/account_response.dart';
import 'package:ya_finance_app/utils/list.dart';

import '../../domain/models/account_history_response.dart';
import '../../domain/models/bank_account.dart';
import '../../domain/repositories/bank_account.dart';
import '../mappers/account_history_response_map.dart';
import '../models/request/account_create_request.dart';
import '../models/request/account_update_request.dart';
import '../models/response/account_history_response.dart';
import '../models/response/account_response.dart';
import 'categories_mock.dart';

final getIt = GetIt.instance;

class BankAccountRepositoryImpl implements BankAccountRepository {
  final ApiClient _dioClient = getIt<ApiClient>();

  @override
  Future<BankAccount> getBankAccountById() async {
    try {
      final response = await _dioClient.get(
        'accounts',
      );
      final List<dynamic> data = response.data;
      final cat = data.map((json) => AccountMapper.fromDto(AccountDto.fromJson(json))).toList();
      return cat[0];
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  @override
  Future<List<BankAccount>> getBankAccounts() async {
    try {
      final response = await _dioClient.get(
        'accounts',
      );
      final List<dynamic> data = response.data;
      final cat = data.map((json) => AccountMapper.fromDto(AccountDto.fromJson(json))).toList();
      return cat;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  @override
  Future<BankAccount> updateBankAccount({required int id, required AccountUpdateRequestDto request}) async {
    try {
      final response = await _dioClient.put(
          'accounts/$id',
          data: {
            "name": request.name,
            "balance": request.balance,
            "currency": request.currency
          }
      );
      return AccountMapper.fromDto(AccountDto.fromJson(response.data));
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  @override
  Future<BankAccount> createBankAccount({required AccountCreateRequestDto request}) async {
    try {
      final response = await _dioClient.post(
          'accounts',
          data: {
            "name": request.name,
            "balance": request.balance,
            "currency": request.currency
          }
      );
      return AccountMapper.fromDto(AccountDto.fromJson(response.data));
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  @override
  Future<bool> deleteBankAccount({required int id}) async {
    try {
      final response = await _dioClient.delete(
        'accounts/$id',
      );
      return true;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  @override
  Future<AccountHistoryResponse> getHistoryBankAccount({required int id}) async {
    try {
      final response = await _dioClient.get(
        'accounts/$id/history',
      );
      final data = response.data;
      print(AccountHistoryResponseDto.fromJson(data));
      return AccountHistoryResponseMapper.fromDto(AccountHistoryResponseDto.fromJson(data));
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }
}