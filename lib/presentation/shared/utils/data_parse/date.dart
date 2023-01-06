import 'package:intl/intl.dart';

class DateParse {

  static returnCollActionDate(DateTime dateTime) {

    final DateFormat format = DateFormat("MMMM");
    var month = format.format(dateTime);
    var day = dateTime.day;

    String outputDay = day / 10 < 1 ? "0$day" : day.toString();

    return "$outputDay of $month";
    



  }
}