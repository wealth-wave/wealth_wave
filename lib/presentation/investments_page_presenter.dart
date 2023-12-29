import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/irr_calculator.dart';

class InvestmentsPagePresenter extends Presenter<InvestmentsPageViewState> {
  final InvestmentApi _investmentApi;
  final IRRCalculator _irrCalculator;

  InvestmentsPagePresenter(
      {final InvestmentApi? investmentApi, final IRRCalculator? irrCalculator})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        _irrCalculator = irrCalculator ?? IRRCalculator(),
        super(InvestmentsPageViewState());

  void fetchInvestments() {
    _investmentApi.getInvestments().then((investments) {
      updateViewState((viewState) {
        viewState.investments = investments.map((e) {
          InvestmentVO investmentVO = InvestmentVO(investment: e);
          _updateIRR(investmentVO);
          return investmentVO;
        }).toList();
      });
    });
  }

  void deleteInvestment({required final int id}) {
    _investmentApi.deleteTransactions(investmentId: id).then((value) =>
        _investmentApi
            .deleteInvestment(id: id)
            .then((value) => fetchInvestments()));
  }

  _updateIRR(InvestmentVO investmentVO) {
    _investmentApi
        .getTransactions(investmentId: investmentVO.investment.id)
        .then((transactions) {
      double irr = _irrCalculator.calculateIRR(
        transactions: transactions
            .map((e) => Transaction(amount: e.amount, date: e.amountInvestedOn))
            .toList(),
        finalValue: investmentVO.investment.value,
        finalDate: investmentVO.investment.valueUpdatedOn,
      );
      investmentVO.irr = irr;
    });
  }
}

class InvestmentsPageViewState {
  List<InvestmentVO> investments = [];
}

class InvestmentVO {
  InvestmentEnriched investment;
  double? irr;

  InvestmentVO({
    required this.investment,
  });
}
