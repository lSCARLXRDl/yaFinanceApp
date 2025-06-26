import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ya_finance_app/data/repositories_impl/bank_account_mock.dart';
import 'account_provider.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Color(0xFF2AE881),
        title: Text(
          'Мои статьи',
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