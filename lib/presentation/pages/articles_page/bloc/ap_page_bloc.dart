import 'dart:async';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:bloc/bloc.dart';
import 'package:provider/provider.dart';
import 'package:ya_finance_app/data/repositories_impl/bank_account_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/transactions_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_mock.dart';

part 'ap_page_event.dart';

part 'ap_page_state.dart';

class ApPageBloc extends Bloc<ApPageEvent, ApPageState> {
  final MockCategoriesRepository categories_repo;

  ApPageBloc(this.categories_repo) : super(ApPageInitial()) {
    on<LoadStatesEvent>(_load);
    on<SearchStatesEvent>(_search);
  }

  Future<void> _search(SearchStatesEvent event, Emitter<ApPageState> emit) async {
    try {
      if (state is! SearchLoaded) {
        emit(SearchLoading());
      }
      final categories = await categories_repo.getCategoriesreal();
      final cat = extractTop(
        query: event.searchStr,
        choices: categories,
        getter: (category) => category.name,
        limit: 5,
        cutoff: 65,
      ).map((result) => result.choice).toList();
      emit(SearchLoaded(categList: cat.toList()));
    } catch (e) {
      emit(SearchFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _load(LoadStatesEvent event, Emitter<ApPageState> emit) async {
    try {
      if (state is! ApPageLoaded) {
        emit(ApPageLoading());
      }
      final categories = await categories_repo.getCategoriesreal();
      emit(ApPageLoaded(categList: categories.toList()));
    } catch (e) {
      emit(ApPageLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}
