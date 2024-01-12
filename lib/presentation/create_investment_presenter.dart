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
    final irr = viewState.irr;
    final maturityDate = viewState.getMaturityDate();

    if (investmentIdToUpdate != null) {
      _investmentApi
          .updateInvestment(
              id: investmentIdToUpdate,
              description: description,
              name: name,
              currentValue: value,
              currentValueUpdatedOn: valueUpdatedAt,
              basketId: basketId,
              riskLevel: riskLevel,
              irr: irr,
              maturityDate: maturityDate)
          .then((_) => updateViewState((viewState) =>
              viewState.onInvestmentCreated = SingleEvent(null)));
    } else {
      _investmentApi
          .createInvestment(
              name: name,
              description: description,
              currentValue: value,
              currentValueUpdatedAt: valueUpdatedAt,
              basketId: basketId,
              riskLevel: riskLevel,
              irr: irr,
              maturityDate: maturityDate)
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
      viewState.value = investmentToUpdate.currentValue;
      viewState.valueUpdatedAt =
          investmentToUpdate.currentValueUpdatedOn != null
              ? formatDate(investmentToUpdate.currentValueUpdatedOn!)
              : null;
      viewState.riskLevel = investmentToUpdate.riskLevel;
    });
  }
}

class CreateInvestmentViewState {
  String name = '';
  String? description;
  int? basketId;
  double? irr;
  RiskLevel riskLevel = RiskLevel.medium;
  double? value;
  String? valueUpdatedAt;
  String? maturityDate;
  SingleEvent<void>? onInvestmentCreated;
  List<BasketDO> baskets = List.empty(growable: false);

  bool isValid() {
    return name.isNotEmpty && basketId != null;
  }

  DateTime? _getValueUpdatedAt() {
    return valueUpdatedAt != null ? parseDate(valueUpdatedAt!) : null;
  }

  DateTime? getMaturityDate() {
    return maturityDate != null ? parseDate(maturityDate!) : null;
  }
}
