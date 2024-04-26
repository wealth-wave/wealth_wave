import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/apis/script_api.dart';
import 'package:wealth_wave/api/apis/sip_api.dart';
import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/basket.dart';

class BasketService {
  final BasketApi _basketApi;
  final InvestmentApi _investmentApi;
  final SipApi _sipApi;
  final TransactionApi _transactionApi;
  final ScriptApi _scriptApi;

  factory BasketService() {
    return _instance;
  }

  static final BasketService _instance = BasketService._();

  BasketService._(
      {BasketApi? basketApi,
      InvestmentApi? investmentApi,
      SipApi? sipApi,
      TransactionApi? transactionApi,
      ScriptApi? scriptApi})
      : _basketApi = basketApi ?? BasketApi(),
        _investmentApi = investmentApi ?? InvestmentApi(),
        _sipApi = sipApi ?? SipApi(),
        _transactionApi = transactionApi ?? TransactionApi(),
        _scriptApi = scriptApi ?? ScriptApi();

  Future<void> create(
          {required final String name, required final String description}) =>
      _basketApi.create(name: name, description: description).then((_) => {});

  Future<List<Basket>> get() async {
    List<InvestmentDO> investmentDOs = await _investmentApi.getAll();
    List<SipDO> sipDOs = await _sipApi.getAll();
    List<TransactionDO> transactionDOs = await _transactionApi.getAll();
    List<BasketDO> basketDOs = await _basketApi.get();
    List<ScriptDO> scriptDOs = await _scriptApi.getAll();
    return basketDOs
        .map((basketDO) => Basket.from(
            basketDO: basketDO,
            investmentDOs: investmentDOs,
            sipDOs: sipDOs,
            transactionDOs: transactionDOs,
            scriptDOs: scriptDOs))
        .toList();
  }

  Future<Basket> getById({required final int id}) async {
    List<InvestmentDO> investmentDOs = await _investmentApi.getAll();
    List<SipDO> sipDOs = await _sipApi.getAll();
    List<TransactionDO> transactionDOs = await _transactionApi.getAll();
    BasketDO basketDO = await _basketApi.getBy(id: id);
    List<ScriptDO> scriptDOs = await _scriptApi.getAll();
    return Basket.from(
        basketDO: basketDO,
        investmentDOs: investmentDOs,
        sipDOs: sipDOs,
        transactionDOs: transactionDOs,
        scriptDOs: scriptDOs);
  }

  Future<void> update(
          {required final int id,
          required final String name,
          required final String? description}) =>
      _basketApi
          .update(id: id, name: name, description: description)
          .then((_) => {});

  Future<void> deleteBy({required final int id}) => _basketApi.deleteBy(id: id);
}
