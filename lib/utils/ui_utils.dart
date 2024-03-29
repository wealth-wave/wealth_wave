import 'dart:ui';

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

String formatToCurrency(double value, { locale = 'en_IN'}) {
  return NumberFormat.currency(locale: locale,  symbol: '', decimalDigits: 0).format(value);
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

DateTime? parseDate(String dateText) {
  try {
    final date = DateFormat('dd/MM/yyyy').parseStrict(dateText);
    if (date.isBefore(DateTime(2100, 1, 1)) &&
        date.isAfter(DateTime(1990, 1, 1))) {
      return date;
    }
  } catch (e) {
    return null;
  }
  return null;
}
