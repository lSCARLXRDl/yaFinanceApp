import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_repository_impl.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_repository_impl.dart';
import '../../../data/mappers/date_map.dart';
import '../../../l10n/app_localizations.dart';
import '../date_picker/date_picker.dart';
import '../donut_chart/donut_chart.dart';
import '../expandable_list/expandable_list.dart';
import 'date_provider.dart';
import 'bloc/ta_bloc.dart';

class TransactionsAnalysis extends StatelessWidget {
  final bool isIncome;

  const TransactionsAnalysis({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DateProvider(),
      child: BlocProvider(
        create:
            (_) =>
                TaBloc(TransactionsRepositoryImpl(), CategoriesRepositoryImpl()),
        child: TransactionsAnalysisState(isIncome: isIncome),
      ),
    );
  }
}

class TransactionsAnalysisState extends StatelessWidget {
  final bool isIncome;

  const TransactionsAnalysisState({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    final dateBloc = BlocProvider.of<TaBloc>(context);
    (isIncome)
        ? dateBloc.add(
          InitIncomeEvent(
            DateMapper.toDate(Provider.of<DateProvider>(context).startDate),
            DateMapper.toDate(Provider.of<DateProvider>(context).endDate),
          ),
        )
        : dateBloc.add(
          InitExpensesEvent(
            DateMapper.toDate(Provider.of<DateProvider>(context).startDate),
            DateMapper.toDate(Provider.of<DateProvider>(context).endDate),
          ),
        );
    return BlocBuilder<TaBloc, TaState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              AppLocalizations.of(context)!.analyze,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFCAC4D0), width: 2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          AppLocalizations.of(context)!.start,
                        style: Theme.of(context).textTheme.titleSmall
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          textStyle: TextStyle(),
                        ),
                        onPressed: () async {
                          final date = await showYaDatePicker(context: context);
                          if (date != null)
                            Provider.of<DateProvider>(
                              context,
                              listen: false,
                            ).changeStartDate(date);
                        },
                        child: Text(
                          Provider.of<DateProvider>(
                            context,
                            listen: false,
                          ).startDate,
                          style: Theme.of(context).textTheme.titleLarge
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFCAC4D0), width: 2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          AppLocalizations.of(context)!.end,
                        style: Theme.of(context).textTheme.titleSmall
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          textStyle: TextStyle(),
                        ),
                        onPressed: () async {
                          final date = await showYaDatePicker(context: context);
                          if (date != null)
                            Provider.of<DateProvider>(
                              context,
                              listen: false,
                            ).changeEndDate(date);
                        },
                        child: Text(
                          Provider.of<DateProvider>(
                            context,
                            listen: false,
                          ).endDate,
                          style: Theme.of(context).textTheme.titleLarge
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child:
                    (state is TaLoaded)
                        ? () {
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFCAC4D0),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.amount,
                                        style: Theme.of(context).textTheme.titleSmall
                                      ),
                                      Text(
                                        '${state.totalAmount.toString()} ₽',
                                        style: Theme.of(context).textTheme.titleSmall
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              /*if (state.categListWithTransac.length > 0)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xFFCAC4D0),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 20,
                                    ),
                                    child: Center(child: DonutChart()),
                                  ),
                                ),*/
                              Expanded(
                                child: ListView.builder(
                                  itemCount: state.categListWithTransac.length,
                                  itemBuilder: (context, index) {
                                    return ExpandableList(
                                      list_categ:
                                          state.categListWithTransac[index],
                                      percent: state.percentList[index],
                                      amount: state.amountList[index],
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
