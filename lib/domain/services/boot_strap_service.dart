import 'package:wealth_wave/domain/services/investment_service.dart';
import 'package:wealth_wave/domain/services/sip_service.dart';

class BootStrapService {
  final SipService _sipService;
  final InvestmentService _investmentService;

  factory BootStrapService() {
    return _instance;
  }

  static final BootStrapService _instance = BootStrapService._();

  BootStrapService._(
      {final SipService? sipService,
      final InvestmentService? investmentService})
      : _sipService = sipService ?? SipService(),
        _investmentService = investmentService ?? InvestmentService();

  Future<void> performBootStrapOperations() {
    return Future.wait([
        _sipService.performSipTransactions(),
        _investmentService.updateValues(),
      ]);
  }
}
