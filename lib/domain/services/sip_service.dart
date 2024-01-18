import 'package:wealth_wave/api/apis/sip_api.dart';
import 'package:wealth_wave/domain/models/sip.dart';

class SipService {
  final SipApi _sipApi;

  SipService({final SipApi? sipApi}) : _sipApi = sipApi ?? SipApi();

  Future<SIP> getBy({required final int id}) async {
    return _sipApi.getById(id: id).then((sipDO) {
      return SIP.from(sipDO: sipDO);
    });
  }
}
