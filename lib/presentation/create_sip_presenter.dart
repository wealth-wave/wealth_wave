import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/sip_frequency.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/utils/ui_utils.dart';
import 'package:wealth_wave/utils/utils.dart';

class CreateSipPresenter extends Presenter<CreateSipViewState> {
  final Investment _investment;

  CreateSipPresenter({required Investment investment})
      : _investment = investment,
        super(CreateSipViewState());

  void createSip({required final int investmentId, final int? sipIdToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final description = viewState.description;
    final amount = viewState.amount;
    final startDate = viewState.getStartDate();
    final endDate = viewState.getEndDate();
    final frequency = viewState.frequency;

    if (sipIdToUpdate != null) {
      _investment
          .updateSip(
              sipId: sipIdToUpdate,
              description: description,
              amount: amount,
              startDate: startDate,
              endDate: endDate,
              frequency: frequency)
          .then((_) => updateViewState(
              (viewState) => viewState.onSipCreated = SingleEvent(null)));
    } else {
      _investment
          .createSip(
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

  void onAmountChanged(String text) {
    updateViewState(
        (viewState) => viewState.amount = double.tryParse(text) ?? 0);
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

  void setSip(SipDO sipToUpdate) {
    updateViewState((viewState) {
      viewState.description = sipToUpdate.description;
      viewState.amount = sipToUpdate.amount;
      viewState.startDate = formatDate(sipToUpdate.startDate);
      viewState.endDate =
          sipToUpdate.endDate != null ? formatDate(sipToUpdate.endDate!) : '';
      viewState.frequency = sipToUpdate.frequency;
    });
  }
}

class CreateSipViewState {
  String? description;
  double amount = 0.0;
  String startDate = formatDate(DateTime.now());
  String endDate = formatDate(DateTime.now().add(const Duration(days: 365)));
  SipFrequency frequency = SipFrequency.monthly;
  SingleEvent<void>? onSipCreated;

  bool isValid() {
    return amount > 0 && isValidDate(startDate) && isValidDate(endDate);
  }

  DateTime getStartDate() {
    return parseDate(startDate);
  }

  DateTime getEndDate() {
    return parseDate(endDate);
  }
}
