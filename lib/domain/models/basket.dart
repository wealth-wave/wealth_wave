import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class Basket {
  final int id;
  final String name;
  final String? description;

  final InvestmentApi _investmentApi;

  Basket(
      {required this.id,
      required this.name,
      required this.description,
      final InvestmentApi? investmentApi})
      : _investmentApi = investmentApi ?? InvestmentApi();

  Future<int> getTotalInvestments() {
    return _investmentApi.getBy(basketId: id).then((value) => value.length);
  }

  Future<double> getInvestedValue() async {
    return _investmentApi
        .getBy(basketId: id)
        .then((investments) => investments
            .map((investmentDO) => Investment.from(investmentDO: investmentDO)))
        .then((investments) => Future.wait(investments
            .map((investment) => investment.getTotalInvestedAmount())))
        .then((investedAmounts) =>
            investedAmounts.reduce((value, element) => value + element));
  }

  Future<double> getValue({final bool considerFuturePayments = false}) async {
    return _investmentApi
        .getBy(basketId: id)
        .then((investments) => investments
            .map((investmentDO) => Investment.from(investmentDO: investmentDO)))
        .then((investments) => Future.wait(investments
            .map((investment) => investment.getValueOn(date: DateTime.now(), considerFuturePayments: considerFuturePayments))))
        .then((values) => values.reduce((value, element) => value + element));
  }

  Future<List<Investment>> getInvestments() {
    return _investmentApi.getBy(basketId: id).then((investments) => investments
        .map((investmentDO) => Investment.from(investmentDO: investmentDO))
        .toList());
  }

  static Basket from({required final BasketDO basketDO}) {
    return Basket(
        id: basketDO.id,
        name: basketDO.name,
        description: basketDO.description);
  }
}
