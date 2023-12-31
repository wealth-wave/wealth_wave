import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/utils/ui_utils.dart';
import 'package:wealth_wave/utils/utils.dart';

class CreateInvestmentPresenter extends Presenter<CreateInvestmentViewState> {
  final InvestmentApi _investmentApi;
  final BasketApi _basketApi;

  CreateInvestmentPresenter(
      {final InvestmentApi? investmentApi, final BasketApi? basketApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        _basketApi = basketApi ?? BasketApi(),
        super(CreateInvestmentViewState());

  void getBaskets() {
    _basketApi.getBaskets().then(
        (value) => updateViewState((viewState) => viewState.baskets = value));
  }

  void createInvestment({int? investmentIdToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final name = viewState.name;
    final description = viewState.description;
    final value = viewState.value;
    final valueUpdatedAt = viewState._getValueUpdatedAt();
    final basketId = viewState.basketId;
    final riskLevel = viewState.riskLevel;

    if (investmentIdToUpdate != null) {
      _investmentApi
          .updateInvestment(
              id: investmentIdToUpdate,
              description: description,
              name: name,
              value: value,
              valueUpdatedAt: valueUpdatedAt,
              basketId: basketId,
              riskLevel: riskLevel)
          .then((_) => updateViewState((viewState) =>
              viewState.onInvestmentCreated = SingleEvent(null)));
    } else {
      _investmentApi
          .createInvestment(
              name: name,
              description: description,
              value: value,
              valueUpdatedAt: valueUpdatedAt,
              basketId: basketId,
              riskLevel: riskLevel)
          .then((investmentId) => updateViewState((viewState) =>
              viewState.onInvestmentCreated = SingleEvent(null)));
    }
  }

  void nameChanged(String text) {
    updateViewState((viewState) => viewState.name = text);
  }

  void descriptionChanged(String text) {
    updateViewState((viewState) => viewState.description = text);
  }

  void valueChanged(String text) {
    updateViewState(
        (viewState) => viewState.value = double.tryParse(text) ?? 0);
  }

  void valueUpdatedDateChanged(String date) {
    updateViewState((viewState) => viewState.valueUpdatedAt = date);
  }

  void baskedIdChanged(int baskedIt) {
    updateViewState((viewState) => viewState.basketId = baskedIt);
  }

  void riskLevelChanged(RiskLevel riskLevel) {
    updateViewState((viewState) => viewState.riskLevel = riskLevel);
  }

  void setInvestment(Investment investmentToUpdate) {
    updateViewState((viewState) {
      viewState.name = investmentToUpdate.name;
      viewState.basketId = investmentToUpdate.basketId;
      viewState.value = investmentToUpdate.value;
      viewState.valueUpdatedAt = formatDate(investmentToUpdate.valueUpdatedOn);
      viewState.riskLevel = investmentToUpdate.riskLevel;
    });
  }
}

class CreateInvestmentViewState {
  String name = '';
  String? description;
  int? basketId;
  RiskLevel riskLevel = RiskLevel.medium;
  double value = 0.0;
  String valueUpdatedAt = formatDate(DateTime.now());
  SingleEvent<void>? onInvestmentCreated;
  List<BasketDO> baskets = List.empty(growable: false);

  bool isValid() {
    return name.isNotEmpty &&
        value > 0 &&
        isValidDate(valueUpdatedAt) &&
        basketId != null;
  }

  DateTime _getValueUpdatedAt() {
    return parseDate(valueUpdatedAt);
  }
}
