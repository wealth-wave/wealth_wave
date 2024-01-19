import 'package:wealth_wave/contract/sip_frequency.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/sip.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';
import 'package:wealth_wave/utils/ui_utils.dart';

class SipsPresenter extends Presenter<SipsViewState> {
  final int _investmentId;
  final InvestmentService _investmentService;

  SipsPresenter(
      {required final int investmentId,
      final InvestmentService? investmentService})
      : _investmentId = investmentId,
        _investmentService = investmentService ?? InvestmentService(),
        super(SipsViewState());

  void getSips() {
    _investmentService
        .getBy(id: _investmentId)
        .then((investment) => investment.getSips())
        .then((sips) => Future.wait(sips.map((sip) => SIPVO.from(sip: sip))))
        .then((sipVOs) => updateViewState((viewState) {
              viewState.sipVOs = sipVOs;
            }));
  }

  void deleteSip({required final int id}) {
    _investmentService
        .getBy(id: _investmentId)
        .then((investment) => investment.deleteSIP(sipId: id))
        .then((_) => getSips());
  }
}

class SipsViewState {
  List<SIPVO> sipVOs = [];
}

class SIPVO {
  final int id;
  final int investmentId;
  final String? description;
  final double amount;
  final String startDate;
  final String? endDate;
  final SipFrequency frequency;

  SIPVO(
      {required this.id,
      required this.investmentId,
      required this.description,
      required this.amount,
      required this.startDate,
      required this.endDate,
      required this.frequency});

  static Future<SIPVO> from({required final SIP sip}) async {
    final DateTime? endDate = sip.endDate;
    return SIPVO(
        id: sip.id,
        investmentId: sip.investmentId,
        description: sip.description,
        amount: sip.amount,
        startDate: formatDate(sip.startDate) ?? '',
        endDate: endDate != null ? formatDate(endDate) ?? '' : '',
        frequency: sip.frequency);
  }
}
