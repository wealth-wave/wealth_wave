import 'package:flutter_test/flutter_test.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/frequency.dart';
import 'package:wealth_wave/domain/models/sip.dart';

void main() {
  group('Sip', () {
    test('should return correct future payments for daily frequency', () {
      final sip = Sip.from(
        sipDO: SipDO(
          id: 1,
          investmentId: 1,
          description: "Test SIP",
          amount: 100.0,
          startDate: DateTime(2023, 1, 1),
          endDate: null,
          frequency: Frequency.daily,
          executedTill: null,
        ),
      );

      final payments = sip.getFuturePayment(till: DateTime(2023, 1, 5));

      expect(payments.length, 5);
      expect(payments[0].amount, 100.0);
      expect(payments[0].createdOn, DateTime(2023, 1, 1));
      expect(payments[1].createdOn, DateTime(2023, 1, 2));
      expect(payments[2].createdOn, DateTime(2023, 1, 3));
      expect(payments[3].createdOn, DateTime(2023, 1, 4));
      expect(payments[4].createdOn, DateTime(2023, 1, 5));
    });

    test('should return correct future payments for monthly frequency', () {
      final sip = Sip.from(
        sipDO: SipDO(
          id: 1,
          investmentId: 1,
          description: "Test SIP",
          amount: 100.0,
          startDate: DateTime(2023, 1, 1),
          endDate: null,
          frequency: Frequency.monthly,
          executedTill: null,
        ),
      );

      final payments = sip.getFuturePayment(till: DateTime(2023, 5, 1));

      expect(payments.length, 5);
      expect(payments[0].amount, 100.0);
      expect(payments[0].createdOn, DateTime(2023, 1, 1));
      expect(payments[1].createdOn, DateTime(2023, 2, 1));
      expect(payments[2].createdOn, DateTime(2023, 3, 1));
      expect(payments[3].createdOn, DateTime(2023, 4, 1));
      expect(payments[4].createdOn, DateTime(2023, 5, 1));
    });
  });
}