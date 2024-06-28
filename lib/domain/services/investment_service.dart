import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/apis/investment_api_impl.dart';
import 'package:wealth_wave/api/apis/script_api.dart';
import 'package:wealth_wave/api/apis/script_api_impl.dart';
import 'package:wealth_wave/api/apis/sip_api.dart';
import 'package:wealth_wave/api/apis/sip_api_impl.dart';
import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/api/apis/transaction_api_impl.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/services/script_executor_service.dart';

class InvestmentService {
  final InvestmentApi _investmentApi;
  final TransactionApi _transactionApi;
  final SipApi _sipApi;
  final ScriptApi _scriptApi;
  final ScriptExecutorService _scriptExecutorService;

  factory InvestmentService() {
    return _instance;
  }

  factory InvestmentService.withMock({required InvestmentApi investmentApi, required TransactionApi transactionApi, required SipApi sipApi, required ScriptApi scriptApi, required ScriptExecutorService scriptExecutorService}) {
    return InvestmentService._(
      investmentApi: investmentApi,
      transactionApi: transactionApi,
      sipApi: sipApi,
      scriptApi: scriptApi,
      scriptExecutorService: scriptExecutorService);
  }

  static final InvestmentService _instance = InvestmentService._();

  InvestmentService._(
      {final InvestmentApi? investmentApi,
      final TransactionApi? transactionApi,
      final SipApi? sipApi,
      final ScriptApi? scriptApi,
      final ScriptExecutorService? scriptExecutorService})
      : _investmentApi = investmentApi ?? InvestmentApiImpl(),
        _transactionApi = transactionApi ?? TransactionApiImpl(),
        _sipApi = sipApi ?? SipApiImpl(),
        _scriptApi = scriptApi ?? ScriptApiImpl(),
        _scriptExecutorService =
            scriptExecutorService ?? ScriptExecutorService();

  Future<void> create(
      {required final String name,
      required final String? description,
      required final int? basketId,
      required final RiskLevel riskLevel,
      required final double investedAmount,
      required final DateTime investedOn,
      required final double? value,
      required final double? qty,
      required final double? irr,
      required final DateTime? maturityDate}) async {
    if ((irr == null || irr <= 0) &&
        (value == null || value <= 0)) {
      throw Exception(
          "Either IRR or Value and Value Updated On must be provided");
    }

    return _investmentApi
        .create(
            name: name,
            description: description,
            basketId: basketId,
            riskLevel: riskLevel,
            value: value,
            valueUpdatedOn: DateTime.now(),
            maturityDate: maturityDate,
            irr: irr)
        .then((investmentId) => _transactionApi.create(
            investmentId: investmentId,
            amount: investedAmount,
            qty: qty ?? 0,
            createdOn: investedOn,
            description: "Initial Investment"));
  }

  Future<List<Investment>> get() async {
    List<ScriptDO> scriptDOs = await _scriptApi.getAll();
    return _investmentApi.getAll().then((investments) => Future.wait(
        investments.map((investmentEnrichedDO) => _sipApi
            .getBy(investmentId: investmentEnrichedDO.id)
            .then((sipDOs) => _transactionApi
                .getBy(investmentId: investmentEnrichedDO.id)
                .then((transactionDOs) => Investment.from(
                    scriptDO: scriptDOs
                        .where(
                            (element) => element.investmentId == investmentEnrichedDO.id)
                        .firstOrNull,
                    investmentDO: investmentEnrichedDO,
                    transactionsDOs: transactionDOs,
                    sipDOs: sipDOs))))));
  }

  Future<Investment> getBy({required final int id}) async {
    List<ScriptDO> scriptDOs = await _scriptApi.getAll();
    return _investmentApi.getById(id: id).then((investmentEnrichedDO) => _sipApi
        .getBy(investmentId: investmentEnrichedDO.id)
        .then((sipDOs) => _transactionApi
            .getBy(investmentId: investmentEnrichedDO.id)
            .then((transactionDOs) => Investment.from(
                scriptDO: scriptDOs
                    .where((element) => element.investmentId == id)
                    .firstOrNull,
                investmentDO: investmentEnrichedDO,
                transactionsDOs: transactionDOs,
                sipDOs: sipDOs))));
  }

  Future<void> update(
      {required final int id,
      required final String name,
      required final String? description,
      required final int? basketId,
      required final RiskLevel riskLevel,
      required final double? value,
      required final double? qty,
      required final double? irr,
      required final DateTime? maturityDate}) {
    return _investmentApi
        .update(
            id: id,
            name: name,
            description: description,
            value: value,
            qty: qty,
            valueUpdatedOn: DateTime.now(),
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

  Future<void> updateValues() async {
    final investments = await _investmentApi.getAll();

    for (final investment in investments) {
      if (investment.valueUpdatedOn != null && DateTime.now().difference(investment.valueUpdatedOn!).inDays < 1) {
        continue;
      }

      final script = await _scriptApi.getBy(investmentId: investment.id);
      if (script == null) {
        continue;
      }
      final value = await _scriptExecutorService.executeScript(script: script.script);

      if (value != null) {
        await _investmentApi.updateValue(
          id: investment.id,
          value: value,
          valueUpdatedOn: DateTime.now(),
        );
      }
    }
  }

  Future<void> updateValue({required int investmentId}) async {
    final investment = await _investmentApi.getById(id: investmentId);
    final script = await _scriptApi.getBy(investmentId: investment.id);
    if (script == null) {
      return;
    }
    final value = await _scriptExecutorService.executeScript(script: script.script);

    if (value != null) {
      await _investmentApi.updateValue(
        id: investment.id,
        value: value,
        valueUpdatedOn: DateTime.now(),
      );
    }
  }
}
