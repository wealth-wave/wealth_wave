import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class DashboardPresenter extends Presenter<DashboardViewState> {
  final InvestmentService _investmentService;

  DashboardPresenter({final InvestmentService? investmentService})
      : _investmentService = investmentService ?? InvestmentService(),
        super(DashboardViewState());

  void fetchDashboard() {}
}

class DashboardViewState {
  double invested = 0;
  double currentValue = 0;
  Map<RiskLevel, double> riskComposition = {};
  Map<String, double> basketComposition = {};
  Map<double, double> irrComposition = {};
}
