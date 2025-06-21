import 'package:dio/dio.dart';
import 'package:ya_finance_app/data/models/shared/category.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/models/category.dart';
import '../../domain/repositories/categories.dart';
import '../mappers/category_map.dart';

final dio = Dio();


class MockCategoriesRepository implements CategoriesRepository {

  final List<CategoryDto> _categoriesList = [
    CategoryDto(id: 1, name: 'Продукты', emoji: '🥐', isIncome: false),
    CategoryDto(id: 2, name: 'Зарплата', emoji: '💸', isIncome: true),
    CategoryDto(id: 3, name: 'Обувь', emoji: '🥾', isIncome: false),
    CategoryDto(id: 4, name: 'Поступление', emoji: '⬆📈', isIncome: true),
  ];
  @override
  Future<List<Category>> getCategories() async{
    await Future.delayed(const Duration(milliseconds: 200));
    return _categoriesList.map((e) => CategoryMapper.fromDto(e)).toList();
  }

  Future<List<Category>> getCategoriesreal() async{
    final apiKey = dotenv.env['API_KEY'];
    try {
      final response = await dio.get(
        'https://shmr-finance.ru/api/v1/categories',
        options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
      );
      final List<dynamic> data = response.data;
      final cat = data.map((json) => CategoryMapper.fromDto(CategoryDto.fromJson(json))).toList();
      print(cat);
      return cat;
    } on DioException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }

  @override
  Future<List<Category>> getCategoriesByType({required bool isIncome}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final _filtered = _categoriesList.where((e) => e.isIncome == isIncome).toList();
    return _filtered.map((e) => CategoryMapper.fromDto(e)).toList();
  }
}