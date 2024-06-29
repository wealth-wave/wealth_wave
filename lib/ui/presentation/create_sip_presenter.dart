import 'package:wealth_wave/contract/frequency.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/sip.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';
import 'package:wealth_wave/domain/services/sip_service.dart';

class CreateSipPresenter extends Presenter<CreateSipViewState> {
  final int _investmentId;
  final SipService _sipService;

  CreateSipPresenter(
      {required final int investmentId,
      final InvestmentService? investmentService,
      final SipService? sipService})
      : _investmentId = investmentId,
        _sipService = sipService ?? SipService(),
        super(CreateSipViewState());

  void createSip({final int? idToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final String description = viewState.description;
    final double amount = viewState.amount;
    final DateTime startDate = viewState.startDate;
    final DateTime? endDate = viewState.endDate;
    final Frequency frequency = viewState.frequency;

    if (idToUpdate != null) {
      _sipService
          .updateSip(
              sipId: idToUpdate,
              description: description,
              amount: amount,
              startDate: startDate,
              endDate: endDate,
              frequency: frequency,
              investmentId: _investmentId)
          .then((_) => updateViewState(
              (viewState) => viewState.onSipCreated = SingleEvent(null)));
    } else {
      _sipService
          .createSip(
              investmentId: _investmentId,
              description: description,
              amount: amount,
              startDate: startDate,
              endDate: endDate,
              frequency: frequency)
          .then((_) => updateViewState(
              (viewState) => viewState.onSipCreated = SingleEvent(null)));
    }
  }

  void onDescriptionChanged(String text) {
    updateViewState((viewState) => viewState.description = text);
  }

  void onAmountChanged(double value) {
    updateViewState((viewState) => viewState.amount = value);
  }

  void startDateChanged(DateTime date) {
    updateViewState((viewState) => viewState.startDate = date);
  }

  void endDateChanged(DateTime? date) {
    updateViewState((viewState) => viewState.endDate = date);
  }

  void onFrequencyChanged(Frequency frequency) {
    updateViewState((viewState) => viewState.frequency = frequency);
  }

  void _setSip(Sip sipToUpdate) {
    updateViewState((viewState) {
      viewState.description = sipToUpdate.description ?? '';
      viewState.amount = sipToUpdate.amount;
      viewState.startDate = sipToUpdate.startDate;
      viewState.endDate = sipToUpdate.endDate;
      viewState.frequency = sipToUpdate.frequency;
      viewState.onSipLoaded = SingleEvent(null);
    });
  }

  void fetchSip({required int id}) {
    _sipService.getById(id: id).then((sip) => _setSip(sip));
  }
}

class CreateSipViewState {
  String description = '';
  double amount = 0;
  DateTime startDate = DateTime.now();
  DateTime? endDate = DateTime.now().add(const Duration(days: 365));
  Frequency frequency = Frequency.monthly;
  SingleEvent<void>? onSipCreated;
  SingleEvent<void>? onSipLoaded;

  bool isValid() {
    final endDate = this.endDate;
    return amount > 0 &&
        (endDate != null && startDate.isBefore(endDate) || endDate == null);
  }
}
