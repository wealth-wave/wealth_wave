class Month {
  final int year;
  final int month;

  Month({required this.year, required this.month});

  int getValue() {
    return year * 100 + month;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Month && other.year == year && other.month == month;
  }

  @override
  int get hashCode => year.hashCode ^ month.hashCode;
}
