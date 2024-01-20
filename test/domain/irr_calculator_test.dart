import 'package:test/test.dart';
import 'package:wealth_wave/domain/models/irr_calculator.dart';
import 'package:wealth_wave/domain/models/payment.dart';

void main() {
  group('IRRCalculator', () {
    test('calculateIRR returns correct IRR', () {
      final calculator = IRRCalculator();
      final payments = [
        Payment(amount: 1000.0, createdOn: DateTime(2020, 1, 1)),
        Payment(amount: 2000.0, createdOn: DateTime(2021, 1, 1)),
        Payment(amount: 3000.0, createdOn: DateTime(2022, 1, 1)),
      ];
      const finalValue = 8000.0;
      final finalDate = DateTime(2023, 1, 1);

      final irr = calculator.calculateIRR(
          payments: payments, value: finalValue, valueUpdatedOn: finalDate);

      expect(irr, closeTo(18.26, 0.02)); // Expected IRR is 20%, tolerance is 1%
    });

    test('calculateIRR returns correct value for multiple payments', () {
      final calculator = IRRCalculator();
      final payments = [
        Payment(amount: 1000.0, createdOn: DateTime(2020, 1, 1)),
        Payment(amount: 2000.0, createdOn: DateTime(2021, 1, 1)),
        Payment(amount: 3000.0, createdOn: DateTime(2022, 1, 1)),
      ];
      const irr = 10.0;
      final futureDate = DateTime(2023, 1, 1);

      final value = calculator.calculateFutureValueOnIRR(
          payments: payments, irr: irr, date: futureDate);

      expect(value, closeTo(7051, 1)); // Expected IRR is 20%, tolerance is 1%
    });

    test('calculateIRR value', () {
      final calculator = IRRCalculator();
      final value = calculator.calculateValueOnIRR(
        currentValue: 1000,
        currentValueUpdatedOn: DateTime(2020, 1, 1),
        irr: 10,
        futureDate: DateTime(2022, 1, 1),
      );

      expect(value, closeTo(1210, 1)); // Expected IRR is 20%, tolerance is 1%
    });
  });
}
