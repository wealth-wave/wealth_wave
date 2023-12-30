import 'package:test/test.dart';
import 'package:wealth_wave/domain/irr_calculator.dart';
import 'package:wealth_wave/domain/models/transaction.dart';

void main() {
  group('IRRCalculator', () {
    test('calculateIRR returns correct IRR', () {
      final calculator = IRRCalculator();
      final transactions = [
        Transaction(id: 0, amount: 1000.0, createdOn: DateTime(2020, 1, 1)),
        Transaction(id: 0, amount: 2000.0, createdOn: DateTime(2021, 1, 1)),
        Transaction(id: 0, amount: 3000.0, createdOn: DateTime(2022, 1, 1)),
      ];
      const finalValue = 8000.0;
      final finalDate = DateTime(2023, 1, 1);

      final irr = calculator.calculateIRR(
          transactions: transactions,
          finalValue: finalValue,
          finalDate: finalDate);

      expect(irr, closeTo(0.2, 0.02)); // Expected IRR is 20%, tolerance is 1%
    });
  });
}
