import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      create: (_) => LtBloc(MockTransactionRepository(), MockCategoriesRepository()),
      child: ListTransactions(isIncome: true),
    );
  }
}
