import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  try {
    return DateFormat('dd/MM/yyyy').format(date);
  } catch (e) {
    return '';
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
  return NumberFormat.currency().format(value);
}

String formatCurrency(String value) {
  return formatDecimal(NumberFormat.currency().parse(value).toDouble());
}

DateTime? parseDate(String date) {
  try {
    return DateFormat('dd-MM-yyyy').parse(date);
  } catch (e) {
    return null;
  }
}
