import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class DashboardPresenter extends Presenter<DashboardViewState> {
  final InvestmentService _investmentService;

  DashboardPresenter({final InvestmentService? investmentService})
      : _investmentService = investmentService ?? InvestmentService(),
        super(DashboardViewState());

  void fetchDashboard() {
    _investmentService.get().then((investments) {
      double invested = 0;
      double currentValue = 0;
      Map<RiskLevel, double> riskComposition = {};
      Map<String, double> basketComposition = {};
      Map<double, double> irrComposition = {};

      for (var investment in investments) {
        double investmentValue = investment.getValueOn(date: DateTime.now());
        invested += investment.getTotalInvestedAmount(till: DateTime.now());
        currentValue += investmentValue;
        riskComposition.update(
            investment.riskLevel, (value) => value + investmentValue,
            ifAbsent: () => investmentValue);
        basketComposition.update(
            investment.basketName ?? '-', (value) => value + investmentValue,
            ifAbsent: () => investmentValue);
        irrComposition.update((investment.getIRR()).roundToDouble(),
            (value) => value + investmentValue,
            ifAbsent: () => investmentValue);
      }

      updateViewState((viewState) {
        viewState.invested = invested;
        viewState.currentValue = currentValue;
        viewState.riskComposition = riskComposition
            .map((key, value) => MapEntry(key, value / currentValue));
        viewState.basketComposition = basketComposition
            .map((key, value) => MapEntry(key, value / currentValue));
        viewState.irrComposition = irrComposition
            .map((key, value) => MapEntry(key, value / currentValue));
      });
    });
  }
}

class DashboardViewState {
  double invested = 0;
  double currentValue = 0;
  Map<RiskLevel, double> riskComposition = {};
  Map<String, double> basketComposition = {};
  Map<double, double> irrComposition = {};
}
