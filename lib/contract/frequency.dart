enum Frequency {
  daily,
  weekly,
  biweekly,
  monthly,
  quarterly,
  halfYearly,
  yearly,
}

DateTime getNextOccurrenceDateTime(DateTime dateTime, Frequency frequency) {
  switch (frequency) {
    case Frequency.daily:
      return DateTime(dateTime.year, dateTime.month, dateTime.day + 1);
    case Frequency.weekly:
      return DateTime(dateTime.year, dateTime.month, dateTime.day + 7);
    case Frequency.biweekly:
      return DateTime(dateTime.year, dateTime.month, dateTime.day + 14);
    case Frequency.monthly:
      return DateTime(dateTime.year, dateTime.month + 1, dateTime.day);
    case Frequency.quarterly:
      return DateTime(dateTime.year, dateTime.month + 3, dateTime.day);
    case Frequency.halfYearly:
      return DateTime(dateTime.year, dateTime.month + 6, dateTime.day);
    case Frequency.yearly:
      return DateTime(dateTime.year + 1, dateTime.month + 6, dateTime.day);
    default:
      throw Exception('Invalid frequency');
  }
}
