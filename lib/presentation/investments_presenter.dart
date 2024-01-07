import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/usecases/fetch_investments_use_case.dart';

class InvestmentsPresenter extends Presenter<InvestmentsViewState> {
  final InvestmentApi _investmentApi;
  final FetchInvestmentsUseCase _fetchInvestmentsUseCase;

  InvestmentsPresenter(
      {final InvestmentApi? investmentApi,
      final FetchInvestmentsUseCase? fetchInvestmentsUseCase})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        _fetchInvestmentsUseCase =
            fetchInvestmentsUseCase ?? FetchInvestmentsUseCase(),
        super(InvestmentsViewState());

  void fetchInvestments() {
    _fetchInvestmentsUseCase.fetchInvestments().then((investments) {
      updateViewState((viewState) {
        viewState.investments = investments;
      });
    });
  }

  void deleteInvestment({required final int id}) {
    _investmentApi
        .deleteSips(investmentId: id)
        .then((value) => _investmentApi.deleteTransactions(investmentId: id))
        .then((value) => _investmentApi.deleteInvestment(id: id));
  }
}

class InvestmentsViewState {
  List<Investment> investments = [];
}
