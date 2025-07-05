import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../data/mappers/date_map.dart';
import '../../../../data/repositories_impl/transactions_mock.dart';


part 'histo_event.dart';

part 'histo_state.dart';

class HistoBloc extends Bloc<HistoEvent, HistoState> {
  HistoBloc(this.transac_repo) : super(HistoInitial()) {
    on<LoadHistogram>(_load);
  }

  final MockTransactionRepository transac_repo;

  Future<void> _load(LoadHistogram event, Emitter<HistoState> emit) async {
    if (event.type == 'day'){
      DateTime nowD = DateTime.now();
      final transacs = await transac_repo.getTransactionsByPeriod(accountId: 149, startDate: nowD.subtract(Duration(days: DateUtils.getDaysInMonth(nowD.year, nowD.month))), endDate: nowD);
      List<int> dayDates = List.generate(DateUtils.getDaysInMonth(nowD.year, nowD.month) - nowD.day , (index) => 1 + nowD.day + index)
      ..addAll(List.generate(nowD.day, (index) => index + 1));
      Map<String, double> lt = {};
      for (final el in dayDates){
        lt[el.toString()] = 0.0;
      }
      for (final tranac in transacs) {
        if (tranac.category.isIncome) {
          lt[tranac.transactionDate.day.toString()] = (lt[tranac.transactionDate.day.toString()] ?? 0.0) + double.parse(tranac.amount);
        }
        else {
          lt[tranac.transactionDate.day.toString()] = (lt[tranac.transactionDate.day.toString()] ?? 0.0) - double.parse(tranac.amount);
        }
      }
      emit(HistogramLoaded(listBalance: lt));
    }
    if (event.type == 'month'){
      DateTime nowD = DateTime.now();
      final transacs = await transac_repo.getTransactionsByPeriod(accountId: 149, startDate: DateTime(nowD.year - 1, nowD.month, nowD.day), endDate: nowD);
      transacs.sort((a, b) => DateMapper.toFullDateTime(a.transactionDate.toString()).compareTo(DateMapper.toFullDateTime(b.transactionDate.toString())));
      List<int> monthDates = List.generate(12 - nowD.month , (index) => 1 + nowD.month + index)
        ..addAll(List.generate(nowD.month, (index) => index + 1));
      Map<String, double> lt = {};
      for (final el in monthDates){
        final mt = await transac_repo.getTransactionsByPeriod(
            accountId: 149,
            startDate: (el > nowD.month) ? DateTime(nowD.year - 1, el, 0) : DateTime(nowD.year, el, 0),
            endDate: (el > nowD.month) ? DateTime(nowD.year - 1, el, DateUtils.getDaysInMonth(nowD.year - 1, el)) : DateTime(nowD.year, el, DateUtils.getDaysInMonth(nowD.year, el))
        );
        if (mt.length > 0)
          lt[el.toString()] = double.parse(mt[mt.length - 1].account.balance);
        else
          lt[el.toString()] = 0.0;
      }
      emit(HistogramLoaded(listBalance: lt));
    }
  }
}