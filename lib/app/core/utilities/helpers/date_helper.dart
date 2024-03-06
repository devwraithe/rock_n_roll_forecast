import 'package:intl/intl.dart';

class DateHelper {
  static String currentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('E, dd MMM');
    final String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String getDayOfWeek(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
}
