import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';

class SipsPresenter extends Presenter<SipsViewState> {
  final InvestmentApi _investmentApi;
  final int investmentId;

  SipsPresenter(this.investmentId,
      {final InvestmentApi? investmentApi, final BasketApi? basketApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        super(SipsViewState(investmentId: investmentId));

  void getSips({required final int investmentId}) {
    _investmentApi
        .getSips(investmentId: investmentId)
        .then((sips) => updateViewState((viewState) {
              viewState.sips = sips;
            }));
  }

  void deleteSip({required final int id}) {
    _investmentApi
        .deleteSip(id: id)
        .then((_) => getSips(investmentId: investmentId));
  }
}

class SipsViewState {
  final int investmentId;
  List<SipDO> sips = [];

  SipsViewState({required this.investmentId});
}
