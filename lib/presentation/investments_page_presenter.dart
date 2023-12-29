import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';

class InvestmentsPagePresenter extends Presenter<InvestmentsPageViewState> {
  final InvestmentApi _investmentApi;

  InvestmentsPagePresenter({final InvestmentApi? investmentApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        super(InvestmentsPageViewState());

  void fetchInvestments() {
    _investmentApi
        .getInvestments()
        .then((investments) => updateViewState((viewState) {
              viewState.investments = investments;
            }));
  }

  void deleteInvestment({required final int id}) {
    _investmentApi.deleteTransactions(investmentId: id).then((value) =>
        _investmentApi
            .deleteInvestment(id: id)
            .then((value) => fetchInvestments()));
  }
}

class InvestmentsPageViewState {
  List<InvestmentEnriched> investments = [];
}

class InvestmentVO {
  InvestmentEnriched investment;

  InvestmentVO({
    required this.investment,
  });
}
