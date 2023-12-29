import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';

class InvestmentsPagePresenter extends Presenter<InvestmentsPageViewState> {
  final InvestmentApi _investmentApi;
  final BasketApi _basketApi;

  InvestmentsPagePresenter(
      {final InvestmentApi? investmentApi, final BasketApi? basketApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        _basketApi = basketApi ?? BasketApi(),
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
