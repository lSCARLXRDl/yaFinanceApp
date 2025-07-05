import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ya_finance_app/data/database/account_db.dart';
import 'package:ya_finance_app/data/repositories_impl/bank_account_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_mock.dart';
import 'package:ya_finance_app/presentation/pages/bank_account_page/bloc_histo/histo_bloc.dart';
import 'package:ya_finance_app/presentation/widgets/spoiler/spoiler.dart';
import '../../widgets/bank_account_histogram/bank_account_histogram.dart';
import '../../widgets/currency_picker/currency_picker.dart';
import 'account_provider.dart';
import 'bloc/ba_page_bloc.dart';
import 'package:shake/shake.dart';

class BankAccountPage extends StatefulWidget {
  const BankAccountPage({super.key});

  @override
  State<BankAccountPage> createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  final _baPageBloc = BaPageBloc(
    MockBankAccountRepository(),
    DBAccountRepository(),
  );
  final _histoBloc = HistoBloc(MockTransactionRepository());
  bool _isTextVisible = true;
  late ShakeDetector detector;

  @override
  void initState() {
    _baPageBloc.add(LoadAccountEvent());
    _histoBloc.add(
      LoadHistogram(
        type: Provider.of<AccountProvider>(context, listen: false).type,
      ),
    );
    detector = ShakeDetector.autoStart(
      onPhoneShake: (ShakeEvent event) {
        setState(() {
          _isTextVisible = !_isTextVisible;
        });
      },
      minimumShakeCount: 2,
      shakeSlopTimeMS: 350,
    );
    super.initState();
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String t = context.watch<AccountProvider>().type;
    _histoBloc.add(
      LoadHistogram(
        type: t,
      ),
    );
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
      body: Column(
        children: [
          BlocBuilder<BaPageBloc, BaPageState>(
            bloc: _baPageBloc,
            builder: (context, state) {
              if (state is BaPageLoaded) {
                // Без реализации обновления названия и баланса счёта на сервере пока так
                if (Provider.of<AccountProvider>(
                      context,
                      listen: false,
                    ).balance ==
                    '') {
                  Provider.of<AccountProvider>(context, listen: false)
                      .balance = state.balance;
                  Provider.of<AccountProvider>(context, listen: false)
                      .account_name = state.account_name;
                  Provider.of<AccountProvider>(context, listen: false)
                      .currency = state.currency;
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
                                  Provider.of<AccountProvider>(
                                    context,
                                  ).account_name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                (_isTextVisible)
                                    ? Text(
                                      '${Provider.of<AccountProvider>(context).balance} ${Provider.of<AccountProvider>(context).currency}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                    : ParticleContainer(
                                      width: 100,
                                      height: 20,
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
                          final currency = await showCurrencyPicker(context);
                          if (currency != null) {
                            Provider.of<AccountProvider>(
                              context,
                              listen: false,
                            ).changeCurrency(currency);
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
                  ],
                );
              }
              if (state is BaPageLoadingFailure) {
                // TODO
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          BlocBuilder<HistoBloc, HistoState>(
            bloc: _histoBloc,
            builder: (context, state) {
              if (state is HistogramLoaded) {
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ChartScreen(values: state.listBalance, context: context,),
                      ),
                      Expanded(flex: 4, child: Container(),)
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
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
