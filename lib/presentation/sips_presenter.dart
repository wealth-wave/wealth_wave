import 'package:wealth_wave/contract/sip_frequency.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/sip.dart';
import 'package:wealth_wave/domain/services/sip_service.dart';

class SipsPresenter extends Presenter<SipsViewState> {
  final int _investmentId;
  final SipService _sipService;

  SipsPresenter({required final int investmentId, final SipService? sipService})
      : _investmentId = investmentId,
        _sipService = sipService ?? SipService(),
        super(SipsViewState());

  void getSips() {
    _sipService
        .getBy(investmentId: _investmentId)
        .then((sips) => sips.map((sip) => SipVO.from(sip: sip)).toList())
        .then((sipVOs) => updateViewState((viewState) {
              viewState.sipVOs = sipVOs;
            }));
  }

  void deleteSip({required final int id}) {
    _sipService.deleteSIP(id: id).then((_) => getSips());
  }
}

class SipsViewState {
  List<SipVO> sipVOs = [];
}

class SipVO {
  final int id;
  final int investmentId;
  final String? description;
  final double amount;
  final DateTime startDate;
  final DateTime? endDate;
  final SipFrequency frequency;

  SipVO._(
      {required this.id,
      required this.investmentId,
      required this.description,
      required this.amount,
      required this.startDate,
      required this.endDate,
      required this.frequency});

  factory SipVO.from({required final Sip sip}) => SipVO._(
      id: sip.id,
      investmentId: sip.investmentId,
      description: sip.description,
      amount: sip.amount,
      startDate: sip.startDate,
      endDate: sip.endDate,
      frequency: sip.frequency);
}
