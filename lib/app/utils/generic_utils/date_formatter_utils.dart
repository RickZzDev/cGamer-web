import 'package:intl/intl.dart';

abstract class DateFormatterUtils {
  static DateTime brazilPatternDateTime(DateTime date) {
    DateFormat formatter = DateFormat("d/M/y");
    String formattedDate = formatter.format(date);
    return DateTime.parse(formattedDate);
  }

  static String brazilPatternString(DateTime date) {
    DateFormat formatter = DateFormat("d/M/y");
    return formatter.format(date);
  }
}
