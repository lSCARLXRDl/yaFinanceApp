import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_repository_impl.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_db_repository.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_repository_impl.dart';
import '../widgets/list_transactions/bloc/lt_bloc.dart';
import '../widgets/list_transactions/list_transactions.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LtBloc(TransactionsRepositoryImpl(), CategoriesRepositoryImpl(), TransactionsDBRepository()),
      child: ListTransactions(isIncome: false),
    );
  }
}
