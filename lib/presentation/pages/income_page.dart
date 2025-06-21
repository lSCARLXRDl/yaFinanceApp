import 'package:flutter/material.dart';

import '../widgets/list_transactions/list_transactions.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  @override
  Widget build(BuildContext context) {
    return ListTransactions(isIncome: true);
  }
}
