import 'package:bloc/bloc.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_mock.dart';


part 'lt_event.dart';
part 'lt_state.dart';

class LtBloc extends Bloc<LtEvent, LtState> {
  LtBloc(this.transac_repo, this.categories_repo) : super(LtInitial()) {
    on<InitExpensesEvent>((event, emit) async {
      final transacs = await transac_repo.getTransactionsByPeriod(accountId: 149, startDate: DateTime.now(), endDate: DateTime.now());
      final transList = transacs.where((el) => el.category.isIncome == false).toList();
      final categoriesList = transList.map((el) => el.category).toList();
      final double totalAmount = transList.fold(0, (sum, transList) => sum + double.parse(transList.amount));
      emit(LtLoaded(transList: transList, categList: categoriesList, totalAmount: totalAmount));
    });

    on<InitIncomeEvent>((event, emit) async {
      final transacs = await transac_repo.getTransactionsByPeriod(accountId: 149, startDate: DateTime.now(), endDate: DateTime.now());
      final transList = transacs.where((el) => el.category.isIncome == true).toList();
      final categoriesList = transList.map((el) => el.category).toList();
      final double totalAmount = transList.fold(0, (sum, transList) => sum + double.parse(transList.amount));
      emit(LtLoaded(transList: transList, categList: categoriesList, totalAmount: totalAmount));
    });
  }

  final MockTransactionRepository transac_repo;
  final MockCategoriesRepository categories_repo;
}