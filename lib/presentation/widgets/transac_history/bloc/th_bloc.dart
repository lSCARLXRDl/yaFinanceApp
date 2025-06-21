import 'package:bloc/bloc.dart';
import 'package:ya_finance_app/data/mappers/date_map.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_mock.dart';


part 'th_event.dart';
part 'th_state.dart';


class ThBloc extends Bloc<ThEvent, ThState> {
  ThBloc(this.transac_repo, this.categories_repo) : super(ThInitial()) {
    on<InitExpensesEvent>((event, emit) async {
      final transacs = await transac_repo.getTransactionsByPeriod(accountId: 1, startDate: event.startDate, endDate: event.endDate);
      final transList = transacs.where((el) => el.category.isIncome == false).toList();
      if (event.sortType == '2'){
        transList.sort((a, b) => DateMapper.toFullDateTime(a.transactionDate.toString()).compareTo(DateMapper.toFullDateTime(b.transactionDate.toString())));
      }
      else if (event.sortType == '3'){
        transList.sort((a, b) => double.parse(a.amount).compareTo(double.parse(b.amount)));
      }
      final categoriesList = transList.map((el) => el.category).toList();
      final double totalAmount = transList.fold(0, (sum, transList) => sum + double.parse(transList.amount));
      emit(ThLoaded(transList: transList, categList: categoriesList, totalAmount: totalAmount));
    });

    on<InitIncomeEvent>((event, emit) async {
      final transacs = await transac_repo.getTransactionsByPeriod(accountId: 1, startDate: event.startDate, endDate: event.endDate);
      final transList = transacs.where((el) => el.category.isIncome == true).toList();
      final categoriesList = transList.map((el) => el.category).toList();
      final double totalAmount = transList.fold(0, (sum, transList) => sum + double.parse(transList.amount));
      emit(ThLoaded(transList: transList, categList: categoriesList, totalAmount: totalAmount));
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