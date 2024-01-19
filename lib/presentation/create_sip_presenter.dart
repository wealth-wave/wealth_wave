import 'package:wealth_wave/contract/sip_frequency.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/sip.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';
import 'package:wealth_wave/domain/services/sip_service.dart';
import 'package:wealth_wave/utils/ui_utils.dart';
import 'package:wealth_wave/utils/utils.dart';

class CreateSipPresenter extends Presenter<CreateSipViewState> {
  final int _investmentId;
  final InvestmentService _investmentService;
  final SipService _sipService;

  CreateSipPresenter(
      {required final int investmentId,
      final InvestmentService? investmentService,
      final SipService? sipService})
      : _investmentId = investmentId,
        _investmentService = investmentService ?? InvestmentService(),
        _sipService = sipService ?? SipService(),
        super(CreateSipViewState());

  void createSip({required final int investmentId, final int? sipIdToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final String description = viewState.description;
    final double amount = double.tryParse(viewState.amount) ?? 0;
    final DateTime startDate = parseDate(viewState.startDate) ?? DateTime.now();
    final DateTime endDate = parseDate(viewState.endDate) ?? DateTime.now();
    final SipFrequency frequency = viewState.frequency;

    _investmentService.getBy(id: _investmentId).then((investment) {
      if (sipIdToUpdate != null) {
        investment
            .updateSip(
                sipId: sipIdToUpdate,
                description: description,
                amount: amount,
                startDate: startDate!,
                endDate: endDate,
                frequency: frequency)
            .then((_) => updateViewState(
                (viewState) => viewState.onSipCreated = SingleEvent(null)));
      } else {
        investment
            .createSip(
                description: description,
                amount: amount,
                startDate: startDate!,
                endDate: endDate,
                frequency: frequency)
            .then((_) => updateViewState(
                (viewState) => viewState.onSipCreated = SingleEvent(null)));
      }
    });
  }

  void onDescriptionChanged(String text) {
    updateViewState((viewState) => viewState.description = text);
  }

  void onAmountChanged(String text) {
    updateViewState((viewState) => viewState.amount = text);
  }

  void startDateChanged(String date) {
    updateViewState((viewState) => viewState.startDate = date);
  }

  void endDateChanged(String date) {
    updateViewState((viewState) => viewState.endDate = date);
  }

  void onFrequencyChanged(SipFrequency frequency) {
    updateViewState((viewState) => viewState.frequency = frequency);
  }

  void setSip(SIP sipToUpdate) {
    updateViewState((viewState) {
      final endDate = sipToUpdate.endDate;
      viewState.description = sipToUpdate.description ?? '';
      viewState.amount = formatToCurrency(sipToUpdate.amount);
      viewState.startDate = formatDate(sipToUpdate.startDate) ?? '';
      viewState.endDate = endDate != null ? formatDate(endDate) ?? '' : '';
      viewState.frequency = sipToUpdate.frequency;
    });
  }

  void fetchSip({required int id}) {
    _sipService.getBy(id: id).then((sip) => setSip(sip));
  }
}

class CreateSipViewState {
  String description = '';
  String amount = '';
  String startDate = formatDate(DateTime.now()) ?? '';
  String endDate =
      formatDate(DateTime.now().add(const Duration(days: 365))) ?? '';
  SipFrequency frequency = SipFrequency.monthly;
  SingleEvent<void>? onSipCreated;

  bool isValid() {
    final double? amount = double.tryParse(this.amount);
    final DateTime? startDate = parseDate(this.startDate);
    final DateTime? endDate = parseDate(this.endDate);

    return amount != null &&
        amount > 0 &&
        startDate != null &&
        (endDate != null && startDate.isBefore(endDate) || endDate == null);
  }
}
