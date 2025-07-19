import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../create_edit_transac/create_edit_provider.dart';
import 'bloc/lt_bloc.dart';

class ListTransactions extends StatefulWidget {
  final bool isIncome;

  const ListTransactions({super.key, required this.isIncome});

  @override
  State<ListTransactions> createState() => _ListTransactionsState(isIncome: isIncome);
}

class _ListTransactionsState extends State<ListTransactions> {
  final bool isIncome;

  _ListTransactionsState({required this.isIncome});

  @override
  void initState() {
    super.initState();
    final cardsListBloc = BlocProvider.of<LtBloc>(context);
    (isIncome)
        ? cardsListBloc.add(InitIncomeEvent())
        : cardsListBloc.add(InitExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LtBloc, LtState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              backgroundColor: Theme.of(context).colorScheme.primary,
              title:
                  (!isIncome)
                      ? Text(
                    AppLocalizations.of(context)!.expencesToday,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                      : Text(
                    AppLocalizations.of(context)!.incomeToday,
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
                      List<dynamic> list_trans = state.transList;
                      List<dynamic> list_categ = state.categList;
                      return Column(
                        children: [
                          Container(
                            color: Theme.of(context).secondaryHeaderColor,
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
                                      AppLocalizations.of(context)!.amount,
                                    style: Theme.of(context).textTheme.titleLarge
                                  ),
                                  Text(
                                    '${state.totalAmount.toString()} ₽',
                                    style: Theme.of(context).textTheme.titleLarge
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
                                    color: Theme.of(context).cardColor,
                                    border: Border.symmetric(
                                      horizontal: BorderSide(
                                        color: Color(0xFFCAC4D0),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).cardColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 22,
                                      ),
                                    ),
                                    onPressed: () {
                                      Provider.of<CreateEditProvider>(context, listen: false,).setEditTransactionInfo(
                                        category: list_categ[index],
                                        transac: list_trans[index],
                                      );
                                      (isIncome)
                                          ? context.goNamed('income_edit')
                                          : context.goNamed('expenses_edit');
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              list_categ[index].emoji,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Container(width: 15),
                                            Text(
                                              list_categ[index].name,
                                              style: Theme.of(context).textTheme.titleSmall,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${list_trans[index].amount} ₽',
                                              style: Theme.of(context).textTheme.titleSmall,
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
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  Provider.of<CreateEditProvider>(
                    context,
                    listen: false,
                  ).updateCreateTransactionInfo(isIncome: isIncome);
                  (isIncome)
                      ? context.goNamed('income_create')
                      : context.goNamed('expenses_create');
                },
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
