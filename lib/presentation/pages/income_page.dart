import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_repository_impl.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_repository_impl.dart';

import '../../data/api/api_client.dart';
import '../../data/repositories_impl/categories_mock.dart';
import '../../data/repositories_impl/transactions_mock.dart';
import '../widgets/list_transactions/bloc/lt_bloc.dart';
import '../widgets/list_transactions/list_transactions.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LtBloc(TransactionsRepositoryImpl(), CategoriesRepositoryImpl()),
      child: ListTransactions(isIncome: true),
    );
  }
}
