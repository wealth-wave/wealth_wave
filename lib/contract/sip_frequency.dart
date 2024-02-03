enum SipFrequency {
  daily,
  weekly,
  biweekly,
  monthly,
  quarterly,
  halfyearly,
  yearly,
}

Duration getDuration(SipFrequency frequency) {
  switch (frequency) {
    case SipFrequency.daily:
      return const Duration(days: 1);
    case SipFrequency.weekly:
      return const Duration(days: 7);
    case SipFrequency.biweekly:
      return const Duration(days: 14);
    case SipFrequency.monthly:
      return const Duration(days: 30);
    case SipFrequency.quarterly:
      return const Duration(days: 91);
    case SipFrequency.halfyearly:
      return const Duration(days: 182);
    case SipFrequency.yearly:
      return const Duration(days: 365);
    default:
      throw Exception('Invalid frequency');
  }
}
