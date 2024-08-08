import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  try {
    return DateFormat('dd/MM/yyyy').format(date);
  } catch (e) {
    return '';
  }
}

String formatToPercentage(double percentage, {final bool forceRound = false}) {
  if (percentage.isNaN) return '';
  return percentage == percentage.round() || forceRound
      ? '${percentage.round()}%'
      : '${percentage.toStringAsFixed(2)}%';
}

String formatDecimal(double value) {
  return value == value.round() ? '${value.round()}' : value.toStringAsFixed(2);
}

String formatToCurrency(double value, { locale = 'en_IN'}) {
  return NumberFormat.currency(locale: locale,  symbol: '', decimalDigits: 0).format(value);
}

double? parseCurrency(String value) {
  try {
    final num number = NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 0).parse(value);
    if (number.isFinite) {
      return number.toDouble();
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

DateTime? parseDate(String dateText) {
  try {
    return DateFormat('dd/MM/yyyy').parseStrict(dateText, true);
  } catch (e) {
    return null;
  }
}
