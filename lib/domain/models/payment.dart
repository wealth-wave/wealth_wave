class Payment {
  final double amount;
  final DateTime createdOn;

  Payment._({
    required this.amount,
    required this.createdOn,
  });

  factory Payment.from({required double amount, required DateTime createdOn}) =>
      Payment._(amount: amount, createdOn: createdOn);
}
