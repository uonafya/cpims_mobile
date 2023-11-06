import 'package:intl/intl.dart';

/// return date as a String in the format - [02-11-23]
String formattedDate(DateTime date) {
  return DateFormat('dd-MM-yy').format(date);
}
