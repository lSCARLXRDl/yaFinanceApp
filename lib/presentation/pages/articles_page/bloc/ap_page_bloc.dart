import 'dart:async';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:bloc/bloc.dart';
import 'package:ya_finance_app/data/repositories_impl/categories_mock.dart';

import '../../../../data/repositories_impl/categories_repository_impl.dart';

part 'ap_page_event.dart';

part 'ap_page_state.dart';

class ApPageBloc extends Bloc<ApPageEvent, ApPageState> {
  final CategoriesRepositoryImpl categoriesRepo;

  ApPageBloc(this.categoriesRepo) : super(ApPageInitial()) {
    on<LoadStatesEvent>(_load);
    on<SearchStatesEvent>(_search);
  }

  Future<void> _search(SearchStatesEvent event, Emitter<ApPageState> emit) async {
    try {
      if (state is! SearchLoaded) {
        emit(SearchLoading());
      }
      final categories = await categoriesRepo.getCategories();
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
      final categories = await categoriesRepo.getCategories();
      emit(ApPageLoaded(categList: categories.toList()));
    } catch (e) {
      emit(ApPageLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}
