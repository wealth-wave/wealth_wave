import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';

class CreateInvestmentDialogPresenter
    extends Presenter<CreateInvestmentPageViewState> {
  final InvestmentApi _investmentApi;
  final BasketApi _basketApi;

  CreateInvestmentDialogPresenter(
      {final InvestmentApi? investmentApi, final BasketApi? basketApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        _basketApi = basketApi ?? BasketApi(),
        super(CreateInvestmentPageViewState());

  void getBaskets() {
    _basketApi.getBaskets().then(
        (value) => updateViewState((viewState) => viewState.baskets = value));
  }

  void createInvestment() {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final name = viewState.name;
    final value = viewState.value;
    final valueUpdatedAt = viewState.valueUpdatedAt;
    final basketId = viewState.basketId;
    final riskLevel = viewState.riskLevel;

    if (viewState.investmentId != null) {
      _investmentApi
          .updateInvestment(
              id: viewState.investmentId!,
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
              value: value,
              valueUpdatedAt: valueUpdatedAt,
              basketId: basketId,
              riskLevel: riskLevel)
          .then((investmentId) => _investmentApi
              .createTransaction(
                  investmentId: investmentId,
                  date: valueUpdatedAt,
                  amount: value)
              .then((_) => updateViewState((viewState) =>
                  viewState.onInvestmentCreated = SingleEvent(null))));
    }
  }

  void nameChanged(String text) {
    updateViewState((viewState) => viewState.name = text);
  }

  void valueChanged(String text) {
    updateViewState(
        (viewState) => viewState.value = double.tryParse(text) ?? 0);
  }

  void valueUpdatedDateChanged(DateTime date) {
    updateViewState((viewState) => viewState.valueUpdatedAt = date);
  }

  void baskedIdChanged(int baskedIt) {
    updateViewState((viewState) => viewState.basketId = baskedIt);
  }

  void riskLevelChanged(RiskLevel riskLevel) {
    updateViewState((viewState) => viewState.riskLevel = riskLevel);
  }

  void setInvestment(InvestmentEnriched investmentToUpdate) {
    updateViewState((viewState) {
      viewState.investmentId = investmentToUpdate.id;
      viewState.name = investmentToUpdate.name;
      viewState.basketId = investmentToUpdate.basketId;
      viewState.value = investmentToUpdate.value;
      viewState.valueUpdatedAt = investmentToUpdate.valueUpdatedOn;
      viewState.riskLevel = investmentToUpdate.riskLevel;
    });
  }
}

class CreateInvestmentPageViewState {
  int? investmentId;
  String name = '';
  int? basketId;
  RiskLevel riskLevel = RiskLevel.medium;
  double value = 0.0;
  DateTime valueUpdatedAt = DateTime.now();
  SingleEvent<void>? onInvestmentCreated;
  List<Basket> baskets = List.empty(growable: false);

  Basket? getBasket() {
    if (basketId == null) {
      return null;
    }
    return baskets.where((element) => element.id == basketId!).first;
  }

  bool isValid() {
    if (investmentId != null) {
      return name.isNotEmpty && basketId != null;
    } else {
      return name.isNotEmpty && value > 0 && basketId != null;
    }
  }
}
