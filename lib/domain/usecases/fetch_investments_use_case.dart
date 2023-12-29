import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/investment_do.dart';

class FetchInvestmentsUseCase {
  final InvestmentApi _investmentApi;

  FetchInvestmentsUseCase({InvestmentApi? investmentApi})
      : _investmentApi = investmentApi ?? InvestmentApi();

  Future<List<InvestmentDO>> fetchInvestments() async {
    List<InvestmentEnriched> investments =
        await _investmentApi.getInvestments();
    List<InvestmentTransaction> transactions =
        await _investmentApi.getTransactions();

    return investments
        .map((investment) => InvestmentDO.from(
            investment: investment,
            transactions: transactions
                .where(
                    (transaction) => transaction.investmentId == investment.id)
                .toList()))
        .toList();
  }
}
