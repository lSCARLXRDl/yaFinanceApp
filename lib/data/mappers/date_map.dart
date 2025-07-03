class DateMapper {
  static String fromDate(DateTime date) {
    String month = (date.month.toString().length == 1) ? '0${date.month}' : date.month.toString();
    String day = (date.day.toString().length == 1) ? '0${date.day}' : date.day.toString();
    return '${date.year}-${month}-${day}';
  }

  static DateTime toDate(String date) {
    List<String> newDate = date.split('-');
    return DateTime(int.parse(newDate[0]), int.parse(newDate[1]), int.parse(newDate[2]));
  }

  static String fromDateToComp(DateTime date) {
    String month = (date.month.toString().length == 1) ? '0${date.month}' : date.month.toString();
    String day = (date.day.toString().length == 1) ? '0${date.day}' : date.day.toString();
    return '${date.year}${month}${day}';
  }

  static DateTime toFullDateTime(String date){
    String ddate = date.split(' ')[0];
    String ttime = date.split(' ')[1].split('.')[0];
    int year = int.parse(ddate.split('-')[0]);
    int month = int.parse(ddate.split('-')[1]);
    int day = int.parse(ddate.split('-')[2]);
    int hour = int.parse(ttime.split(':')[0]);
    int minute = int.parse(ttime.split(':')[1]);
    int second = int.parse(ttime.split(':')[2]);
    return DateTime(year, month, day, hour, minute, second);
  }

  static String fromTime(DateTime date) {
    String hour = (date.hour.toString().length == 1) ? '0${date.hour}' : date.hour.toString();
    String minute = (date.minute.toString().length == 1) ? '0${date.minute}' : date.minute.toString();
    return '${hour}:${minute}';
  }

  static String fromStringDate(String date) {
    final List dt = date.split('-');
    String month = (dt[1].length == 1) ? '0${dt[1]}' : dt[1];
    String day = (dt[2].length == 1) ? '0${dt[2]}' : dt[2];
    return '${dt[0]}-${month}-${day}';
  }
}