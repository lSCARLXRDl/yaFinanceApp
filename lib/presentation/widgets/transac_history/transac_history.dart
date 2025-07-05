import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ya_finance_app/data/mappers/date_map.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_mock.dart';
import 'package:provider/provider.dart';
import 'package:ya_finance_app/presentation/widgets/transac_history/date_provider.dart';

import '../create_edit_transac/create_edit_provider.dart';
import '../date_picker/date_picker.dart';
import 'bloc/th_bloc.dart';

class TransactionsHistory extends StatelessWidget {
  final bool isIncome;

  const TransactionsHistory({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DateProvider(),
      child: BlocProvider(
        create:
            (_) =>
                ThBloc(MockTransactionRepository(), MockCategoriesRepository()),
        child: TransactionsHistoryState(isIncome: isIncome),
      ),
    );
  }
}

class TransactionsHistoryState extends StatelessWidget {
  final bool isIncome;

  const TransactionsHistoryState({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    final dateBloc = BlocProvider.of<ThBloc>(context, listen: false);
    (isIncome)
        ? dateBloc.add(
          InitIncomeEvent(
            DateMapper.toDate(Provider.of<DateProvider>(context).startDate),
            DateMapper.toDate(Provider.of<DateProvider>(context).endDate),
            Provider.of<DateProvider>(context, listen: false).sortType,
          ),
        )
        : dateBloc.add(
          InitExpensesEvent(
            DateMapper.toDate(Provider.of<DateProvider>(context).startDate),
            DateMapper.toDate(Provider.of<DateProvider>(context).endDate),
            Provider.of<DateProvider>(context, listen: false).sortType,
          ),
        );
    return BlocBuilder<ThBloc, ThState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Color(0xFF2AE881),
            title: Text(
              'Моя история',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: SvgPicture.asset(
                    'lib/assets/icons/analysis.svg',
                    height: 30,
                    colorFilter: ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    (isIncome)
                        ? context.goNamed('income_analysis')
                        : context.goNamed('expenses_analysis');
                  },
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD4FAE6),
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD4FAE6),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  onPressed: () async {
                    final date = await showYaDatePicker(context: context);
                    if (date != null)
                      Provider.of<DateProvider>(
                        context,
                        listen: false,
                      ).changeStartDate(date);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Начало',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        Provider.of<DateProvider>(
                          context,
                          listen: false,
                        ).startDate,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                //),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD4FAE6),
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD4FAE6),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  onPressed: () async {
                    final date = await showYaDatePicker(context: context);
                    if (date != null)
                      Provider.of<DateProvider>(context, listen: false,).changeEndDate(date);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Конец',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        Provider.of<DateProvider>(
                          context,
                          listen: false,
                        ).endDate,
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
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD4FAE6),
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFCAC4D0), width: 1),
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
                      Text(
                        'Сортировка',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      DropdownButton<String>(
                        dropdownColor: Colors.white,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        value:
                            Provider.of<DateProvider>(
                              context,
                              listen: true,
                            ).sortType,
                        hint: const Text('Выберите вариант'),
                        items: const [
                          DropdownMenuItem(value: '1', child: Text('Без')),
                          DropdownMenuItem(value: '2', child: Text('По дате')),
                          DropdownMenuItem(value: '3', child: Text('По сумме')),
                        ],
                        onChanged: (String? newValue) {
                          Provider.of<DateProvider>(
                            context,
                            listen: false,
                          ).changeSortType(newValue!);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child:
                    (state is ThLoaded)
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Сумма',
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
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color(0xFFCAC4D0),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 16,
                                          ),
                                        ),
                                        onPressed: () {
                                          Provider.of<CreateEditProvider>(context, listen: false).setEditTransactionInfo(category: list_categ[index], transac: list_trans[index]);
                                          (isIncome)
                                              ? context.goNamed('income_history_edit')
                                              : context.goNamed('expenses_history_edit');
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  list_categ[index].emoji,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Container(width: 15),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      list_categ[index].name,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    if (list_trans[index]
                                                            .comment !=
                                                        null)
                                                      Text(
                                                        list_trans[index]
                                                            .comment,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color(
                                                            0xFF49454F,
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '${list_trans[index].amount} ₽',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${list_trans[index].transactionDate.toString().split(' ')[1].split(':')[0]}:${list_trans[index].transactionDate.toString().split(' ')[1].split(':')[1]}',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
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
              ),
            ],
          ),
        );
      },
    );
  }
}
