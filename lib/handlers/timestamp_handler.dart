import 'package:intl/intl.dart';

String formatDateTime(String dateTime) {
  DateTime date = DateTime.parse(dateTime);
  final formatter = DateFormat('d MMM');
  final formattedDate = formatter.format(date);
  return formattedDate;
}
