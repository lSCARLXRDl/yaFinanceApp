import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_mock.dart';

import '../../../data/repositories_impl/categories_mock.dart';
import 'bloc/lt_bloc.dart';

class ListTransactions extends StatelessWidget {
  final bool isIncome;

  const ListTransactions({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LtBloc(MockTransactionRepository(), MockCategoriesRepository()),
      child: ListTransactionsState(isIncome: isIncome,),
    );
  }
}

class ListTransactionsState extends StatelessWidget {
  final bool isIncome;

  const ListTransactionsState({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    final cardsListBloc = BlocProvider.of<LtBloc>(context);
    (isIncome)
        ? cardsListBloc.add(InitIncomeEvent())
        : cardsListBloc.add(InitExpensesEvent());
    return BlocBuilder<LtBloc, LtState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Color(0xFF2AE881),
            title:
                (!isIncome)
                    ? Text(
                      'Расходы сегодня',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                    : Text(
                      'Доходы сегодня',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: SvgPicture.asset(
                    'lib/assets/icons/transac_history.svg',
                    height: 30,
                    colorFilter: ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    (isIncome)
                        ? context.goNamed('income_history')
                        : context.goNamed('expenses_history');
                  },
                ),
              ),
            ],
          ),
          body:
              (state is LtLoaded)
                  ? () {
                  var list_trans = state.transList;
                  var list_categ = state.categList;
                    return Column(
                      children: [
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
                                  'Всего',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${state.totalAmount.toString()} ₽',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: list_categ.length,
                            itemBuilder: (context, index) {
                              //print(list_trans[index]);
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                    vertical: 22,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          (!isIncome)
                                              ? Text(
                                                list_categ[index].emoji,
                                                style: TextStyle(fontSize: 20),
                                              )
                                              : Container(),
                                          (!isIncome)
                                              ? Container(width: 15)
                                              : Container(),
                                          Text(
                                            list_categ[index].name,
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
                                            '${list_trans[index].amount} ₽',
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
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }()
                  : Center(child: CircularProgressIndicator()),
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
      },
    );
  }
}
