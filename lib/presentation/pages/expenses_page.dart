import 'package:flutter/material.dart';

import '../widgets/list_transactions/list_transactions.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return ListTransactions(isIncome: false);
  }
}
