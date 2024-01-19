import 'package:intl/intl.dart';

String? formatDate(DateTime date) {
  try {
    return DateFormat('dd/MM/yyyy').format(date);
  } catch (e) {
    return null;
  }
}

String formatToPercentage(double value) {
  double percentage = value * 100;
  return percentage == percentage.round()
      ? '${percentage.round()}%'
      : '${percentage.toStringAsFixed(2)}%';
}

String formatDecimal(double value) {
  return value == value.round() ? '${value.round()}' : value.toStringAsFixed(2);
}

String formatToCurrency(double value) {
  return NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(value);
}
