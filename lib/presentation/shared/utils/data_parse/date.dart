import 'package:intl/intl.dart';

enum DateFormatOutput { withYear, withoutYear }

class DateParse {
  static returnCollActionDate(
      DateTime dateTime, DateFormatOutput dateFormatOutput) {
    final DateFormat format = DateFormat("MMMM");
    var month = format.format(dateTime);
    var day = dateTime.day;
    String ordinalDay;

    if (day >= 11 && day <= 13) {
      ordinalDay = "${day}th";
    } else {
      switch (day % 10) {
        case 1:
          ordinalDay = "${day}st";
          break;
        case 2:
          ordinalDay = "${day}nd";
          break;
        case 3:
          ordinalDay = "${day}rd";
          break;
        default:
          ordinalDay = "${day}th";
          break;
      }
    }

    if (dateFormatOutput == DateFormatOutput.withoutYear) {
      return "$ordinalDay of $month ";
    }

    if (dateFormatOutput == DateFormatOutput.withYear) {
      var year = dateTime.year;
      return "$month $ordinalDay, $year";
    }
  }
}
