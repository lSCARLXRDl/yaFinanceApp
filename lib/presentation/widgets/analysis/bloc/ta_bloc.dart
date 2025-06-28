import 'package:bloc/bloc.dart';
import 'package:ya_finance_app/data/mappers/percent_map.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_mock.dart';

part 'ta_event.dart';
part 'ta_state.dart';


class TaBloc extends Bloc<TaEvent, TaState> {
  TaBloc(this.transac_repo, this.categories_repo) : super(TaInitial()) {
    on<InitExpensesEvent>((event, emit) async {
      final transacs = await transac_repo.getTransactionsByPeriod(accountId: 1, startDate: event.startDate, endDate: event.endDate);
      final transList = transacs.where((el) => el.category.isIncome == false).toList();
      final categoriesList = transList.map((el) => el.category).toList();

      List uniqueCategories = categoriesList.fold([], (list, category) {
        return list.any((c) => c.id == category.id) ? list : [...list, category];
      });

      Map<dynamic, List<dynamic>> transactionsByCategory = {
        for (int i = 0; i < uniqueCategories.length; i++)
          i: transacs.where((transaction) => transaction.category.id == uniqueCategories[i].id).toList()
      };

      final double totalAmount = transList.fold(0, (sum, transList) => sum + double.parse(transList.amount));

      final List<double> amountList = [];
      final List<String> percentList = [];
      for (int i = 0; i < transactionsByCategory.length; i++) {
        var el = transactionsByCategory[i];
        double nAmount = el!.fold(0, (sum, el) => sum + double.parse(el.amount));
        amountList.add(nAmount);
        percentList.add(PercentMapper.roundDouble(nAmount / totalAmount * 100));
      }


      emit(TaLoaded(categListWithTransac: transactionsByCategory, percentList: percentList, amountList: amountList, totalAmount: totalAmount));
    });

    on<InitIncomeEvent>((event, emit) async {
      final transacs = await transac_repo.getTransactionsByPeriod(accountId: 1, startDate: event.startDate, endDate: event.endDate);
      final transList = transacs.where((el) => el.category.isIncome == true).toList();
      final categoriesList = transList.map((el) => el.category).toList();

      List uniqueCategories = categoriesList.fold([], (list, category) {
        return list.any((c) => c.id == category.id) ? list : [...list, category];
      });

      Map<dynamic, List<dynamic>> transactionsByCategory = {
        for (int i = 0; i < uniqueCategories.length; i++)
          i: transacs.where((transaction) => transaction.category.id == uniqueCategories[i].id).toList()
      };

      final double totalAmount = transList.fold(0, (sum, transList) => sum + double.parse(transList.amount));

      final List<double> amountList = [];
      final List<String> percentList = [];
      for (int i = 0; i < transactionsByCategory.length; i++) {
        var el = transactionsByCategory[i];
        double nAmount = el!.fold(0, (sum, el) => sum + double.parse(el.amount));
        amountList.add(nAmount);
        percentList.add(PercentMapper.roundDouble(nAmount / totalAmount * 100));
      }


      emit(TaLoaded(categListWithTransac: transactionsByCategory, percentList: percentList, amountList: amountList, totalAmount: totalAmount));
    });

    on<StartDatePick>((event, emit) {
      final date = '${event.startDate.year}-${event.startDate.month}-${event.startDate.day}';
      emit(DatePicked(startDate: date));
    });

    on<EndDatePick>((event, emit) {
      final date = '${event.endDate.year}-${event.endDate.month}-${event.endDate.day}';
      emit(DatePicked(endDate: date));
    });
  }

  final MockTransactionRepository transac_repo;
  final MockCategoriesRepository categories_repo;
}