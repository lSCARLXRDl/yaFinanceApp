import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ya_finance_app/data/database/account_db.dart';
import 'package:ya_finance_app/data/repositories_impl/bank_account_mock.dart';
import 'account_provider.dart';
import 'bloc/ba_page_bloc.dart';

class BankAccountPage extends StatefulWidget {
  const BankAccountPage({super.key});

  @override
  State<BankAccountPage> createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  final _baPageBloc = BaPageBloc(MockBankAccountRepository(), DBAccountRepository());

  @override
  void initState() {
    _baPageBloc.add(LoadAccountEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xFF2AE881),
        title: Text(
          'Мой счет',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: SvgPicture.asset(
                'lib/assets/icons/account_edit.svg',
                height: 30,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              onPressed: () {
                context.goNamed('bank_account_edit');
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _baPageBloc.add(LoadAccountEvent(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<BaPageBloc, BaPageState>(
          bloc: _baPageBloc,
          builder: (context, state) {
            if (state is BaPageLoaded) {
              // Без реализации обновления названия и баланса счёта на сервере пока так
              if (Provider.of<AccountProvider>(context, listen: false).balance == '') {
                Provider.of<AccountProvider>(context, listen: false).balance = state.balance;
                Provider.of<AccountProvider>(context, listen: false).account_name = state.account_name;
                Provider.of<AccountProvider>(context, listen: false).currency = state.currency;
              }
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD4FAE6),
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Color(0xFFCAC4D0),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("💰", style: TextStyle(fontSize: 20)),
                              Container(width: 15),
                              Text(
                                Provider.of<AccountProvider>(context).account_name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${Provider.of<AccountProvider>(context).balance} ${Provider.of<AccountProvider>(context).currency}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(width: 20),
                              Icon(
                                Icons.navigate_next,
                                color: Color(0xFFCAC4D0),
                                size: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD4FAE6),
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFCAC4D0),
                          width: 1,
                        ),
                      ),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD4FAE6),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      onPressed: () async {
                        final currency = await _showCurrencyPicker(context);
                        if (currency != null) {
                          Provider.of<AccountProvider>(context, listen: false).changeCurrency(currency);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Валюта',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                Provider.of<AccountProvider>(
                                  context,
                                ).currency,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Container(width: 20),
                              Icon(
                                Icons.navigate_next,
                                color: Color(0xFFCAC4D0),
                                size: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Color(0xFFA2A8A6),
                      child: Center(child: Text('ЗДЕСЬ БУДЕТ ГРАФИК')),
                    ),
                  ),
                  Expanded(flex: 5, child: Container(color: Colors.white)),
                ],
              );
            }
            if (state is BaPageLoadingFailure) {
              // TODO
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: Container(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Color(0xFF2AE881),
          onPressed: () {},
          child: Icon(Icons.add, color: Colors.white, size: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}

Future<String?> _showCurrencyPicker(BuildContext context) async {
  String? cur = null;
  final dialog = await showModalBottomSheet<String?>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
          color: Color(0xFFF7F2FA),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Color(0xFF79747E),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF7F2FA),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: () {
                    cur = '₽';
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        '₽',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Российский рубль ₽',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF7F2FA),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  onPressed: () {
                    cur = '\$';
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Американский доллар \$',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF7F2FA),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {
                  cur = '€';
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Text(
                      '€',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Евро',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE46962),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {
                  cur = null;
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.cancel_outlined, color: Colors.white, size: 30),
                    SizedBox(width: 10),
                    Text(
                      'Отмена',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
  return cur;
}
