import 'package:wealth_wave/api/apis/sip_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/sip.dart';

class Transaction {
  final int id;
  final int investmentId;
  final int? sipId;
  final String? description;
  final double amount;
  final DateTime createdOn;

  final SipApi _sipApi;

  Transaction(
      {required this.id,
      required this.investmentId,
      required this.sipId,
      required this.description,
      required this.amount,
      required this.createdOn,
      final SipApi? sipApi})
      : _sipApi = sipApi ?? SipApi();

  Future<SIP?> getSip() {
    if (sipId == null) {
      return Future.value(null);
    }

    return _sipApi.getById(id: sipId!).then((sipDO) => SIP.from(sipDO: sipDO));
  }

  static Transaction from({required final TransactionDO transactionDO}) {
    return Transaction(
        id: transactionDO.id,
        investmentId: transactionDO.investmentId,
        sipId: transactionDO.sipId,
        description: transactionDO.description,
        amount: transactionDO.amount,
        createdOn: transactionDO.createdOn);
  }
}
