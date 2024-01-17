import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class InvestmentsPresenter extends Presenter<InvestmentsViewState> {
  final InvestmentService _investmentService;

  InvestmentsPresenter({final InvestmentService? investmentService})
      : _investmentService = investmentService ?? InvestmentService(),
        super(InvestmentsViewState());

  void fetchInvestments() {
    _investmentService.get().then((investments) {
      updateViewState((viewState) {
        viewState.investments = investments;
      });
    });
  }

  void deleteInvestment({required final int id}) {
    _investmentService.deleteBy(id: id).then((value) => fetchInvestments());
  }
}

class InvestmentsViewState {
  List<Investment> investments = [];
}
