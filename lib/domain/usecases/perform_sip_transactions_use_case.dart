import 'package:wealth_wave/api/apis/investment_api.dart';

class PerformSipTransactionsUseCase {
  final InvestmentApi _investmentApi;

  PerformSipTransactionsUseCase({final InvestmentApi? investmentApi})
      : _investmentApi = investmentApi ?? InvestmentApi();

  Future<void> performSipTransactions() async {
    return _investmentApi.getSips().then((sips) {
      for (var sip in sips) {
        if (sip.startDate.isBefore(DateTime.now())) {
          var diff = sip.startDate.difference(DateTime.now()).inDays;
          var frequency = sip.frequency;
          if (diff > frequency) {
            for (DateTime i = sip.startDate;
                i.isBefore(DateTime.now());
                i.add(Duration(days: frequency.toInt()))) {
              _investmentApi
                  .createTransaction(
                      investmentId: sip.investmentId,
                      description: 'SIP',
                      amount: sip.amount,
                      date: sip.startDate)
                  .await;
            }
          }

          _investmentApi
              .createTransaction(
                  investmentId: sip.investmentId,
                  amount: sip.amount,
                  date: sip.startDate)
              .then((_) => _investmentApi.updateSip(
                  id: sip.id,
                  startDate: sip.startDate.add(Duration(days: 30))));
        }
      }
    });
  }
}
