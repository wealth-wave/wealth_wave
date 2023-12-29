import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/investment_do.dart';
import 'package:wealth_wave/domain/usecases/fetch_investments_use_case.dart';

class InvestmentsPagePresenter extends Presenter<InvestmentsPageViewState> {
  final InvestmentApi _investmentApi;
  final FetchInvestmentsUseCase _fetchInvestmentsUseCase;

  InvestmentsPagePresenter(
      {final InvestmentApi? investmentApi,
      final FetchInvestmentsUseCase? fetchInvestmentsUseCase})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        _fetchInvestmentsUseCase =
            fetchInvestmentsUseCase ?? FetchInvestmentsUseCase(),
        super(InvestmentsPageViewState());

  void fetchInvestments() {
    _fetchInvestmentsUseCase.fetchInvestments().then((investments) {
      updateViewState((viewState) {
        viewState.investments = investments;
      });
    });
  }

  void deleteInvestment({required final int id}) {
    _investmentApi.deleteTransactions(investmentId: id).then((value) =>
        _investmentApi
            .deleteInvestment(id: id)
            .then((value) => fetchInvestments()));
  }
}

class InvestmentsPageViewState {
  List<InvestmentDO> investments = [];
}
