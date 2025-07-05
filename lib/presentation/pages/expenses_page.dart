import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories_impl/categories_mock.dart';
import '../../data/repositories_impl/transactions_mock.dart';
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
      create: (_) => LtBloc(MockTransactionRepository(), MockCategoriesRepository()),
      child: ListTransactions(isIncome: false),
    );
  }
}
