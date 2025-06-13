import 'package:flutter/material.dart';

class BankAccountPage extends StatefulWidget {
  const BankAccountPage({super.key});

  @override
  State<BankAccountPage> createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('BankAccountPage', style: TextStyle(fontSize: 30),),
    );
  }
}
