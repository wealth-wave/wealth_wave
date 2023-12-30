import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  try {
    return DateFormat('dd-MM-yyyy').format(date);
  } catch (e) {
    return '-';
  }
}

String formatToPercentage(double value) {
  return '${(value * 100).toStringAsFixed(2)}%';
}
