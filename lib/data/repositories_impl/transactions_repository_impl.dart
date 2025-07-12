import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_finance_app/data/mappers/date_map.dart';
import 'package:ya_finance_app/data/mappers/transaction_response_map.dart';
import 'package:ya_finance_app/data/models/shared/transaction.dart';
import 'package:dio/dio.dart';

import '../../domain/models/transaction.dart';
import '../../domain/models/transaction_response.dart';
import '../../domain/repositories/transactions.dart';
import '../api/api_client.dart';
import '../mappers/transaction_map.dart';
import '../models/request/transaction_request.dart';
import '../models/response/transaction_response.dart';

final getIt = GetIt.instance;

class TransactionsRepositoryImpl implements TransactionRepository {
  final ApiClient _dioClient = getIt<ApiClient>();

  @override
  Future<Transaction> createTransaction({required TransactionRequestDto request}) async {
    try {
      final response = await _dioClient.post(
          'transactions',
          data: {
            "accountId": request.accountId,
            "categoryId": request.categoryId,
            "amount": request.amount,
            "transactionDate": request.transactionDate,
            "comment": request.comment
          }
      );
      return TransactionMapper.fromDto(TransactionDto.fromJson(response.data));
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  @override
  Future<bool> deleteTransaction({required int id}) async {
    try {
      final response = await _dioClient.delete(
        'transactions/$id',
      );
      return true;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  @override
  Future<TransactionResponse> getTransactionById({required int id}) async {
    try {
      final response = await _dioClient.get(
        'transactions/$id',
      );
      final data = response;
      final cat = TransactionResponseMapper.fromDto(TransactionResponseDto.fromJson(data));
      return cat;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  @override
  Future<TransactionResponse> updateTransaction({
    required int id,
    required TransactionRequestDto request,
  }) async {
    try {
      final response = await _dioClient.put(
          'transactions/$id',
          data: {
            "accountId": request.accountId,
            "categoryId": request.categoryId,
            "amount": request.amount,
            "transactionDate": request.transactionDate,
            "comment": request.comment
          }
      );
      return TransactionResponseMapper.fromDto(TransactionResponseDto.fromJson(response.data));
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  @override
  Future<List<TransactionResponse>> getTransactionsByPeriod({required int accountId, DateTime? startDate, DateTime? endDate}) async{
    final now = DateTime.now();
    String startDateR = (startDate != null) ? DateMapper.fromDate(startDate) : DateMapper.fromDate(DateTime(now.year, now.month, 1));
    String endDateR = (endDate != null) ? DateMapper.fromDate(endDate) : DateMapper.fromDate(DateTime(now.year, now.month + 1, 1).subtract(Duration(days: 1)));
    try {
      final response = await _dioClient.get(
        'transactions/account/${accountId}/period?startDate=${startDateR}&endDate=${endDateR}',
      );
      final List<dynamic> data = response;
      final cat = data.map((json) => TransactionResponseMapper.fromDto(TransactionResponseDto.fromJson(json))).toList();
      return cat;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }
}