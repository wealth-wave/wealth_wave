import 'package:wealth_wave/api/apis/sip_api.dart';
import 'package:wealth_wave/api/apis/transaction_api.dart';
import 'package:wealth_wave/contract/frequency.dart';
import 'package:wealth_wave/domain/models/sip.dart';

class SipService {
  final SipApi _sipApi;
  final TransactionApi _transactionApi;

  factory SipService() {
    return _instance;
  }

  static final SipService _instance = SipService._();

  SipService._({final SipApi? sipApi, final TransactionApi? transactionApi})
      : _sipApi = sipApi ?? SipApi(),
        _transactionApi = transactionApi ?? TransactionApi();

  Future<Sip> createSip(
          {required final int investmentId,
          required final String? description,
          required final double amount,
          required final DateTime startDate,
          required final DateTime? endDate,
          required final Frequency frequency}) =>
      _sipApi
          .create(
              investmentId: investmentId,
              description: description,
              amount: amount,
              startDate: startDate,
              endDate: endDate,
              frequency: frequency)
          .then((id) => _sipApi.getById(id: id))
          .then((sipDO) => Sip.from(sipDO: sipDO))
          .then((sip) => _performSipTransaction(sip).then((_) => sip));

  Future<Sip> getById({required final int id}) =>
      _sipApi.getById(id: id).then((sipDO) {
        return Sip.from(sipDO: sipDO);
      });

  Future<List<Sip>> getBy({final int? investmentId}) => _sipApi
      .getBy(investmentId: investmentId)
      .then((sips) => sips.map((sipDO) => Sip.from(sipDO: sipDO)).toList());

  Future<List<Sip>> getAll() => _sipApi
      .getAll()
      .then((sips) => sips.map((sipDO) => Sip.from(sipDO: sipDO)).toList());

  Future<Sip> updateSip(
          {required final int sipId,
          required final int investmentId,
          required final String? description,
          required final double amount,
          required final DateTime startDate,
          required final DateTime? endDate,
          required final Frequency frequency}) =>
      _sipApi
          .update(
              id: sipId,
              investmentId: investmentId,
              description: description,
              amount: amount,
              startDate: startDate,
              endDate: endDate,
              frequency: frequency)
          .then((count) => _sipApi.getById(id: sipId))
          .then((sipDO) => Sip.from(sipDO: sipDO))
          .then((sip) => _transactionApi
              .deleteBy(sipId: sipId)
              .then((_) => _performSipTransaction(sip))
              .then((_) => sip));

  Future<void> _performSipTransaction(Sip sip) => Future.wait(sip
      .getFuturePayment(till: DateTime.now())
      .map((payment) => _transactionApi.create(
          investmentId: sip.investmentId,
          description: sip.description,
          amount: payment.amount,
          createdOn: payment.createdOn)));

  Future<void> deleteSIP({required final int id}) => _transactionApi
      .deleteBy(sipId: id)
      .then((_) => _sipApi.deleteBy(id: id))
      .then((_) => {});

  Future<void> performSipTransactions() => _sipApi
      .getAll()
      .then((sipDOs) => sipDOs.map((sipDO) => Sip.from(sipDO: sipDO)))
      .then((sips) => sips.map((sip) => _performSipTransaction(sip)))
      .then((_) => {});
}
