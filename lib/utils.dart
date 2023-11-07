import 'package:intl/intl.dart';

/// return date as a String in the format - [2023-11-23]
String formattedDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}
