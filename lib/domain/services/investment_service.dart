import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/apis/sip_api.dart';
import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/domain/models/investment.dart';

class InvestmentService {
  final InvestmentApi _investmentApi;
  final TransactionApi _transactionApi;
  final SipApi _sipApi;

  factory InvestmentService() {
    return _instance;
  }

  static final InvestmentService _instance = InvestmentService._();

  InvestmentService._(
      {final InvestmentApi? investmentApi,
      final TransactionApi? transactionApi,
      final SipApi? sipApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        _transactionApi = transactionApi ?? TransactionApi(),
        _sipApi = sipApi ?? SipApi();

  Future<void> create(
      {required final String name,
      required final String? description,
      required final int? basketId,
      required final RiskLevel riskLevel,
      required final double? investedAmount,
      required final DateTime? investedOn,
      required final double? value,
      required final DateTime? valueUpdatedOn,
      required final double? irr,
      required final DateTime? maturityDate}) async {
    if ((irr == null || irr <= 0) &&
        (value == null || value <= 0 || valueUpdatedOn == null)) {
      throw Exception(
          "Either IRR or Value and Value Updated On must be provided");
    }

    return _investmentApi
        .create(
            name: name,
            description: description,
            basketId: basketId,
            riskLevel: riskLevel,
            investedAmount: investedAmount,
            investedOn: investedOn,
            value: value,
            maturityDate: maturityDate,
            irr: irr,
            valueUpdatedOn: valueUpdatedOn)
        .then((_) => {});
  }

  Future<List<Investment>> get() async {
    return _investmentApi.getAll().then((investments) => Future.wait(
        investments.map((investmentEnrichedDO) => _sipApi
            .getBy(investmentId: investmentEnrichedDO.id)
            .then((sipDOs) => _transactionApi
                .getBy(investmentId: investmentEnrichedDO.id)
                .then((transactionDOs) => Investment.from(
                    investmentDO: investmentEnrichedDO,
                    transactionsDOs: transactionDOs,
                    sipDOs: sipDOs))))));
  }

  Future<Investment> getBy({required final int id}) async {
    return _investmentApi.getById(id: id).then((investmentEnrichedDO) => _sipApi
        .getBy(investmentId: investmentEnrichedDO.id)
        .then((sipDOs) => _transactionApi
            .getBy(investmentId: investmentEnrichedDO.id)
            .then((transactionDOs) => Investment.from(
                investmentDO: investmentEnrichedDO,
                transactionsDOs: transactionDOs,
                sipDOs: sipDOs))));
  }

  Future<void> update(
      {required final int id,
      required final String name,
      required final String? description,
      required final int? basketId,
      required final double? investedAmount,
      required final DateTime? investedOn,
      required final RiskLevel riskLevel,
      required final double? value,
      required final DateTime? valueUpdatedOn,
      required final double? irr,
      required final DateTime? maturityDate}) {
    return _investmentApi
        .update(
            id: id,
            name: name,
            description: description,
            investedAmount: investedAmount,
            investedOn: investedOn,
            value: value,
            valueUpdatedOn: valueUpdatedOn,
            irr: irr,
            maturityDate: maturityDate,
            riskLevel: riskLevel,
            basketId: basketId)
        .then((_) => {});
  }

  Future<void> deleteBy({required final int id}) => _transactionApi
      .deleteBy(investmentId: id)
      .then((_) => _sipApi.deleteBy(investmentId: id))
      .then((_) => _investmentApi.deleteBy(id: id));
}
