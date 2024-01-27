import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  try {
    return DateFormat('dd/MM/yyyy').format(date);
  } catch (e) {
    return '';
  }
}

String formatToPercentage(double percentage, {final bool forceRound = false}) {
  return percentage == percentage.round() || forceRound
      ? '${percentage.round()}%'
      : '${percentage.toStringAsFixed(2)}%';
}

String formatDecimal(double value) {
  return value == value.round() ? '${value.round()}' : value.toStringAsFixed(2);
}

String formatToCurrency(double value) {
  return NumberFormat.currency(symbol: '', decimalDigits: 2).format(value);
}

double? parseCurrency(String value) {
  try {
    final num number = NumberFormat.currency().parse(value);
    if (number.isFinite) {
      return number.toDouble();
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

DateTime? parseDate(String date) {
  try {
    return DateFormat('dd/MM/yyyy').parseStrict(date);
  } catch (e) {
    return null;
  }
}
