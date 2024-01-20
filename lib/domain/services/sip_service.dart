import 'package:wealth_wave/api/apis/sip_api.dart';
import 'package:wealth_wave/domain/models/sip.dart';

class SipService {
  final SipApi _sipApi;

  factory SipService() {
    return _instance;
  }

  static final SipService _instance = SipService._();

  SipService._({final SipApi? sipApi}) : _sipApi = sipApi ?? SipApi();

  Future<SIP> getBy({required final int id}) async {
    return _sipApi.getById(id: id).then((sipDO) {
      return SIP.from(sipDO: sipDO);
    });
  }

  Future<void> performSipTransactions() {
    return _sipApi
        .getAll()
        .then((sipDOs) =>
            Future.wait(sipDOs.map((sipDO) => SIP.from(sipDO: sipDO))))
        .then((sips) => sips.map((sip) => sip.performSipTransactions()))
        .then((_) => {});
  }
}
