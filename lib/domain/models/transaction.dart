class Transaction {
  final int id;
  final int investmentId;
  final double amount;
  final DateTime investedOn;

  Transaction(
      {required this.id,
      required this.investmentId,
      required this.amount,
      required this.investedOn});
}
