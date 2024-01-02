import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class FetchInvestmentsUseCase {
  final InvestmentApi _investmentApi;

  FetchInvestmentsUseCase({InvestmentApi? investmentApi})
      : _investmentApi = investmentApi ?? InvestmentApi();

  Future<List<Investment>> fetchInvestments() async {
    List<InvestmentEnrichedDO> investments =
        await _investmentApi.getEnrichedInvestments();
    List<TransactionDO> transactions = await _investmentApi.getTransactions();
    List<GoalInvestmentEnrichedMappingDO> goalInvestmentMappings =
        await _investmentApi.getGoalInvestmentMappings();

    return investments
        .map((investment) => Investment.from(
            investment: investment,
            transactions: transactions
                .where(
                    (transaction) => transaction.investmentId == investment.id)
                .toList(),
            goalInvestmentMappings: goalInvestmentMappings
                .where((goalInvestmentMapping) =>
                    goalInvestmentMapping.investmentId == investment.id)
                .toList()))
        .toList();
  }
}
