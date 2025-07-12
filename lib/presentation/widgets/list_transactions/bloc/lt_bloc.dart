import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_finance_app/data/database/category_db.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_repository_impl.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_db_repository.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_repository_impl.dart';
import 'package:ya_finance_app/domain/models/account_brief.dart';

import '../../../../domain/models/category.dart';
import '../../../../domain/models/transaction_response.dart';


part 'lt_event.dart';
part 'lt_state.dart';

final getIt = GetIt.instance;
final CategoryDb category_db = getIt<CategoryDb>();

class LtBloc extends Bloc<LtEvent, LtState> {

  Future<bool> hasRealInternet() async {
    try {
      final socket = await Socket.connect('8.8.8.8', 53, timeout: const Duration(seconds: 2));
      await socket.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  LtBloc(this.transac_repo, this.categories_repo, this.transac_db_repo) : super(LtInitial()) {
    on<InitExpensesEvent>((event, emit) async {
      if (await hasRealInternet()) {
        final transacs = await transac_repo.getTransactionsByPeriod(accountId: 149, startDate: DateTime.now(), endDate: DateTime.now());
        final transList = transacs.where((el) => el.category.isIncome == false).toList();
        final categoriesList = transList.map((el) => el.category).toList();
        final double totalAmount = transList.fold(0, (sum, transList) => sum + double.parse(transList.amount));
        emit(LtLoaded(transList: transList, categList: categoriesList, totalAmount: totalAmount, isIncome: false));
      }
      else {
        final transacs = await transac_db_repo.getTransactionsByPeriod(accountId: 149,  startDate: DateTime.now(), endDate: DateTime.now());
        final categList = await category_db.getCategoriesByType(isIncome: false);

        final categoryMap = {for (final category in categList)category.id: category};

        final transList =  transacs.map((transaction) {
          final category = categoryMap[transaction.categoryId] ??
              Category(
                  id: -1,
                  name: 'Неизвестно',
                  emoji: '❓',
                  isIncome: false
              );
          return TransactionResponse(
            id: transaction.id,
            account: AccountBrief(id: 1, name: '', balance: "135.22", currency: 'RUB'),
            category: category,
            amount: transaction.amount,
            transactionDate: transaction.transactionDate,
            comment: transaction.comment,
            createdAt: transaction.createdAt,
            updatedAt: transaction.updatedAt,
          );
        }).toList();
        final categoriesList = transList.map((el) => el.category).toList();
        final double totalAmount = transList.fold(0, (sum, transList) => sum + double.parse(transList.amount));
        emit(LtLoaded(transList: transList, categList: categoriesList, totalAmount: totalAmount, isIncome: false));
      }
    });

    on<InitIncomeEvent>((event, emit) async {
      final transacs = await transac_repo.getTransactionsByPeriod(accountId: 149, startDate: DateTime.now(), endDate: DateTime.now());
      final transList = transacs.where((el) => el.category.isIncome == true).toList();
      final categoriesList = transList.map((el) => el.category).toList();
      final double totalAmount = transList.fold(0, (sum, transList) => sum + double.parse(transList.amount));
      emit(LtLoaded(transList: transList, categList: categoriesList, totalAmount: totalAmount, isIncome: true));
    });
  }

  final TransactionsRepositoryImpl transac_repo;
  final CategoriesRepositoryImpl categories_repo;
  final TransactionsDBRepository transac_db_repo;
}