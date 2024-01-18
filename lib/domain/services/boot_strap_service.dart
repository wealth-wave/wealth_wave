import 'package:wealth_wave/domain/services/sip_service.dart';

class BootStrapService {
  final SipService _sipService;

  BootStrapService({final SipService? sipService})
      : _sipService = sipService ?? SipService();

  Future<void> performBootStrapOperations() {
    return _sipService.performSipTransactions();
  }
}
