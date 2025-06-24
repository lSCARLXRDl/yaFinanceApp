import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ya_finance_app/data/repositories_impl/bank_account_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_mock.dart';

import '../../../../data/repositories_impl/categories_mock.dart';
import 'bloc/ba_page_bloc.dart';

class BankAccountPage extends StatefulWidget {
  const BankAccountPage({super.key});

  @override
  State<BankAccountPage> createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  final _baPageBloc = BaPageBloc(MockBankAccountRepository());

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
              onPressed: () {},
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
                                'Баланс',
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
                                '${state.balance} ${state.currency}',
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
                    color: Color(0xFFD4FAE6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Валюта',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${state.currency}',
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
            if (state is BaPageLoadingFailure) {}
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
