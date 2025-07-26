import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_finance_app/data/models/shared/category.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/models/category.dart';
import '../../domain/repositories/categories.dart';
import '../api/api_client.dart';
import '../mappers/category_map.dart';

final getIt = GetIt.instance;

class CategoriesRepositoryImpl implements CategoriesRepository {
  final ApiClient _dioClient = getIt<ApiClient>();

  @override
  Future<List<Category>> getCategories() async{
    try {
      final response = await _dioClient.get(
        'categories',
      );
      final List<dynamic> data = response;
      final cat = data.map((json) => CategoryMapper.fromDto(CategoryDto.fromJson(json))).toList();
      return cat;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  @override
  Future<List<Category>> getCategoriesByType({required bool isIncome}) async {
    try {
      final response = await _dioClient.get(
        'categories/type/$isIncome',
      );
      final List<dynamic> data = response;
      final cat = data.map((json) => CategoryMapper.fromDto(CategoryDto.fromJson(json))).toList();
      return cat;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }
}