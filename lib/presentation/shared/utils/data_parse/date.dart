import 'package:intl/intl.dart';

enum DateFormatOutput { withYear, withoutYear }

class DateParse {
  static returnCollActionDate(
      DateTime dateTime, DateFormatOutput dateFormatOutput) {
    final DateFormat format = DateFormat("MMMM");
    var month = format.format(dateTime);
    var day = dateTime.day;

    if(dateFormatOutput == DateFormatOutput.withoutYear) {
      String outputDay = day / 10 < 1 ? "0$day" : day.toString();
      return "$outputDay of $month";
    }

    if(dateFormatOutput == DateFormatOutput.withYear) {
      var year = dateTime.year;
      return "$day of $month, $year";
    }
  }
}
