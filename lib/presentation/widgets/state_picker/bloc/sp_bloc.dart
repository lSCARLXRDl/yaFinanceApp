import 'dart:async';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:bloc/bloc.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_mock.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_repository_impl.dart';

part 'sp_event.dart';

part 'sp_state.dart';

class SpPageBloc extends Bloc<SpPageEvent, SpPageState> {
  final CategoriesRepositoryImpl categories_repo;

  SpPageBloc(this.categories_repo) : super(SpPageInitial()) {
    on<LoadStatesEvent>(_load);
    on<SearchStatesEvent>(_search);
  }

  Future<void> _search(SearchStatesEvent event, Emitter<SpPageState> emit) async {
    try {
      if (state is! SearchLoaded) {
        emit(SearchLoading());
      }
      final categoriesReq = await categories_repo.getCategories();
      final categories = categoriesReq.where((el) => el.isIncome == event.isIncome).toList();
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

  Future<void> _load(LoadStatesEvent event, Emitter<SpPageState> emit) async {
    try {
      if (state is! SpPageLoaded) {
        emit(SpPageLoading());
      }
      final categories = await categories_repo.getCategories();
      final cat = categories.where((el) => el.isIncome == event.isIncome).toList();
      emit(SpPageLoaded(categList: cat));
    } catch (e) {
      emit(SpPageLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}