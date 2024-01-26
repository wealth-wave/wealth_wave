import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/apis/sip_api.dart';
import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/basket.dart';

class BasketService {
  final BasketApi _basketApi;
  final InvestmentApi _investmentApi;
  final SipApi _sipApi;
  final TransactionApi _transactionApi;

  factory BasketService() {
    return _instance;
  }

  static final BasketService _instance = BasketService._();

  BasketService._(
      {BasketApi? basketApi,
      InvestmentApi? investmentApi,
      SipApi? sipApi,
      TransactionApi? transactionApi})
      : _basketApi = basketApi ?? BasketApi(),
        _investmentApi = investmentApi ?? InvestmentApi(),
        _sipApi = sipApi ?? SipApi(),
        _transactionApi = transactionApi ?? TransactionApi();

  Future<void> create(
          {required final String name, required final String description}) =>
      _basketApi.create(name: name, description: description).then((_) => {});

  Future<List<Basket>> get() async {
    List<InvestmentDO> investmentDOs = await _investmentApi.getAll();
    List<SipDO> sipDOs = await _sipApi.getAll();
    List<TransactionDO> transactionDOs = await _transactionApi.getAll();
    List<BasketDO> basketDOs = await _basketApi.get();
    return basketDOs
        .map((basketDO) => Basket.from(
            basketDO: basketDO,
            investmentDOs: investmentDOs,
            sipDOs: sipDOs,
            transactionDOs: transactionDOs))
        .toList();
  }

  Future<Basket> getById({required final int id}) async {
    List<InvestmentDO> investmentDOs = await _investmentApi.getAll();
    List<SipDO> sipDOs = await _sipApi.getAll();
    List<TransactionDO> transactionDOs = await _transactionApi.getAll();
    BasketDO basketDO = await _basketApi.getBy(id: id);
    return Basket.from(
        basketDO: basketDO,
        investmentDOs: investmentDOs,
        sipDOs: sipDOs,
        transactionDOs: transactionDOs);
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
