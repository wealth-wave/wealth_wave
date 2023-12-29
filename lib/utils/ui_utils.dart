import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}

String formatToPercentage(double value) {
  return '${(value * 100).toStringAsFixed(2)}%';
}
