import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class InvestmentService {
  final InvestmentApi _investmentApi;

  InvestmentService({final InvestmentApi? investmentApi})
      : _investmentApi = investmentApi ?? InvestmentApi();

  Future<Investment> create(
      {required final String name,
      required final String description,
      required final int basketId,
      required final RiskLevel riskLevel,
      required final double? value,
      required final DateTime? valueUpdatedOn,
      required final double? irr,
      required final DateTime? maturityDate}) {
    return _investmentApi
        .create(
            name: name,
            description: description,
            basketId: basketId,
            riskLevel: riskLevel,
            value: value,
            maturityDate: maturityDate,
            irr: irr,
            valueUpdatedOn: valueUpdatedOn)
        .then((investmentId) => _investmentApi.getById(id: investmentId))
        .then((investmentDO) => Investment.from(investmentDO: investmentDO));
  }

  Future<List<Investment>> get() async {
    return _investmentApi.get().then((investments) => investments
        .map((investmentDO) => Investment.from(investmentDO: investmentDO))
        .toList());
  }

  Future<Investment> getBy({required final int id}) async {
    return _investmentApi.getById(id: id).then((investmentDO) {
      return Investment.from(investmentDO: investmentDO);
    });
  }

  Future<Investment> update(Investment investment) {
    return _investmentApi
        .update(
            id: investment.id,
            name: investment.name,
            description: investment.description,
            value: investment.value,
            valueUpdatedOn: investment.valueUpdatedOn,
            irr: investment.irr,
            maturityDate: investment.maturityDate,
            riskLevel: investment.riskLevel,
            basketId: investment.basketId)
        .then((value) => _investmentApi.getById(id: investment.id))
        .then((investmentDO) => Investment.from(investmentDO: investmentDO));
  }

  Future<void> deleteBy({required final int id}) {
    return _investmentApi.deleteBy(id: id);
  }
}
