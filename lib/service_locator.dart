import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_finance_app/data/database/category_db.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_repository_impl.dart';

import 'data/api/api_client.dart';
import 'data/database/transaction_db.dart';
import 'data/database/transaction_event_db.dart';
import 'data/repositories_impl/bank_account_repository_impl.dart';
import 'data/repositories_impl/transactions_repository_impl.dart';



final getIt = GetIt.instance;

Future<void> setupDependencies() async {

  getIt.registerSingleton<ApiClient>(ApiClient());

  getIt.registerLazySingleton<TransactionEventDb>(() => TransactionEventDb());
  getIt.registerLazySingleton<TransactionDb>(() => TransactionDb());
  getIt.registerLazySingleton<CategoryDb>(() => CategoryDb());

  getIt.registerLazySingleton<BankAccountRepositoryImpl>(() => BankAccountRepositoryImpl());
  getIt.registerLazySingleton<CategoriesRepositoryImpl>(() => CategoriesRepositoryImpl());
  getIt.registerLazySingleton<TransactionsRepositoryImpl>(() => TransactionsRepositoryImpl());
}