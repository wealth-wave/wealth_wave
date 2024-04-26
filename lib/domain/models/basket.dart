import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class Basket {
  final int id;
  final String name;
  final String? description;
  final int expectedInvestmentPercentage;
  final List<Investment> investments;

  Basket._(
      {required this.id,
      required this.name,
      required this.description,
      required this.expectedInvestmentPercentage,
      required this.investments});

  int get totalInvestment => investments.length;

  double get investedValue => investments
      .map((investment) => investment.getTotalInvestedAmount())
      .fold(0, (previousValue, element) => previousValue + element);

  factory Basket.from(
          {required final BasketDO basketDO,
          required final List<InvestmentDO> investmentDOs,
          required final List<ScriptDO> scriptDOs,
          required final List<SipDO> sipDOs,
          required final List<TransactionDO> transactionDOs}) =>
      Basket._(
          id: basketDO.id,
          name: basketDO.name,
          description: basketDO.description,
          expectedInvestmentPercentage: 0,
          investments: investmentDOs
              .where((investment) => investment.basketId == basketDO.id)
              .map((investmentDO) => Investment.from(
                  investmentDO: investmentDO,
                  scriptDO: scriptDOs.where((scriptDO) => scriptDO.investmentId == investmentDO.id).firstOrNull,
                  sipDOs: sipDOs
                      .where((sipDO) => sipDO.investmentId == investmentDO.id)
                      .toList(),
                  transactionsDOs: transactionDOs
                      .where((transactionDO) =>
                          transactionDO.investmentId == investmentDO.id)
                      .toList()))
              .toList());
}
