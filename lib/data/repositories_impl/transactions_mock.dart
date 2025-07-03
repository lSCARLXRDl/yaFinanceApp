import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ya_finance_app/data/mappers/date_map.dart';
import 'package:ya_finance_app/data/mappers/transaction_response_map.dart';
import 'package:ya_finance_app/data/models/shared/transaction.dart';
import 'package:dio/dio.dart';

import '../../domain/models/transaction.dart';
import '../../domain/models/transaction_response.dart';
import '../../domain/repositories/transactions.dart';
import '../mappers/transaction_map.dart';
import '../models/request/transaction_request.dart';
import '../models/response/transaction_response.dart';


final dio = Dio();

class MockTransactionRepository implements TransactionRepository {
  final List<TransactionDto> _transactionsList = [
    TransactionDto(
      id: 1,
      accountId: 1,
      categoryId: 1,
      amount: '500.00',
      transactionDate: DateTime(2025, 6, 12, 15, 47),
      comment: null,
      createdAt: DateTime(2025, 6, 12, 15, 47),
      updatedAt: DateTime(2025, 6, 12, 15, 47),
    ),
    TransactionDto(
      id: 2,
      accountId: 1,
      categoryId: 2,
      amount: '75000.00',
      transactionDate: DateTime(2025, 5, 30, 12, 13),
      comment: 'Зарплата за месяц',
      createdAt: DateTime(2025, 5, 30, 12, 13),
      updatedAt: DateTime(2025, 5, 30, 12, 13),
    ),
    TransactionDto(
      id: 3,
      accountId: 1,
      categoryId: 3,
      amount: '5200.00',
      transactionDate: DateTime(2025, 6, 2, 18, 31),
      comment: 'Обувной магазин',
      createdAt: DateTime(2025, 6, 2, 18, 31),
      updatedAt: DateTime(2025, 6, 2, 18, 31),
    ),
    TransactionDto(
      id: 4,
      accountId: 1,
      categoryId: 4,
      amount: '1300.00',
      transactionDate: DateTime(2025, 6, 2, 15, 00),
      comment: 'Вернул',
      createdAt: DateTime(2025, 6, 2, 15, 00),
      updatedAt: DateTime(2025, 6, 2, 15, 00),
    ),
  ];
  int transid = 4;

  @override
  Future<Transaction> createTransaction({required TransactionRequestDto request}) async {
    final apiKey = dotenv.env['API_KEY'];
    try {
      final response = await dio.post(
        'https://shmr-finance.ru/api/v1/transactions',
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
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
    final apiKey = dotenv.env['API_KEY'];
    try {
      final response = await dio.delete(
          'https://shmr-finance.ru/api/v1/transactions/$id',
          options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );
      return true;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  @override
  Future<TransactionResponse> getTransactionById({required int id}) async {
    final apiKey = dotenv.env['API_KEY'];
    try {
      final response = await dio.get(
        'https://shmr-finance.ru/api/v1/transactions/$id',
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );
      final data = response.data;
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
    final apiKey = dotenv.env['API_KEY'];
    try {
      final response = await dio.put(
          'https://shmr-finance.ru/api/v1/transactions/$id',
          options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
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
    final apiKey = dotenv.env['API_KEY'];
    String startDateR = (startDate != null) ? DateMapper.fromDate(startDate) : DateMapper.fromDate(DateTime(now.year, now.month, 1));
    String endDateR = (endDate != null) ? DateMapper.fromDate(endDate) : DateMapper.fromDate(DateTime(now.year, now.month + 1, 1).subtract(Duration(days: 1)));
    try {
      final response = await dio.get(
        'https://shmr-finance.ru/api/v1/transactions/account/${accountId}/period?startDate=${startDateR}&endDate=${endDateR}',
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );
      final List<dynamic> data = response.data;
      final cat = data.map((json) => TransactionResponseMapper.fromDto(TransactionResponseDto.fromJson(json))).toList();
      return cat;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }
}