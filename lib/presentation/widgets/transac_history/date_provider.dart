import 'package:flutter/material.dart';

import '../../../data/mappers/date_map.dart';

class DateProvider extends ChangeNotifier {
  late DateTime now;
  late String startDate;
  late String endDate;
  late int endDateToComp;
  late int startDateToComp;
  String sortType = '1';


  DateProvider() {
    now = DateTime.now();
    endDate = '${now.year}-${now.month}-${now.day}';
    endDateToComp = int.parse(DateMapper.fromDateToComp(now));
    if (now.month == 1) {
      startDate = '${now.year - 1}-12-${now.day}';
      startDateToComp = int.parse(DateMapper.fromDateToComp(DateTime(now.year - 1, 12, now.day)));
    }
    else {
      startDate = '${now.year}-${now.month - 1}-${now.day}';
      startDateToComp = int.parse(DateMapper.fromDateToComp(DateTime(now.year, now.month - 1, now.day)));
    }
  }

  void changeSortType(String type) {
    sortType = type;
    notifyListeners();
  }

  void changeStartDate(DateTime date){
    startDate = '${date.year}-${date.month}-${date.day}';
    startDateToComp = int.parse(DateMapper.fromDateToComp(date));
    if (endDateToComp < startDateToComp){
      endDate = startDate;
      endDateToComp = int.parse(DateMapper.fromDateToComp(date));
    }
    notifyListeners();
  }

  void changeEndDate(DateTime date){
    endDate = '${date.year}-${date.month}-${date.day}';
    endDateToComp = int.parse(DateMapper.fromDateToComp(date));
    if (endDateToComp < startDateToComp){
      startDate = endDate;
      startDateToComp = int.parse(DateMapper.fromDateToComp(date));
    }
    notifyListeners();
  }
}