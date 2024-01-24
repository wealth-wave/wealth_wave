import 'package:wealth_wave/domain/services/sip_service.dart';

class BootStrapService {
  final SipService _sipService;

  factory BootStrapService() {
    return _instance;
  }

  static final BootStrapService _instance = BootStrapService._();

  BootStrapService._({final SipService? sipService})
      : _sipService = sipService ?? SipService();

  Future<void> performBootStrapOperations() =>
      _sipService.performSipTransactions();
}
