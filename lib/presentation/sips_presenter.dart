import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/models/sip.dart';

class SipsPresenter extends Presenter<SipsViewState> {
  final Investment _investment;

  SipsPresenter({required final Investment investment})
      : _investment = investment,
        super(SipsViewState());

  void getSips() {
    _investment.getSips().then((sips) => updateViewState((viewState) {
          viewState.sips = sips;
        }));
  }

  void deleteSip({required final int id}) {
    _investment.deleteSIP(sipId: id).then((_) => getSips());
  }
}

class SipsViewState {
  List<SIP> sips = [];
}
