import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/services/basket_service.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class CreateInvestmentPresenter extends Presenter<CreateInvestmentViewState> {
  final InvestmentService _investmentService;
  final BasketService _basketService;

  CreateInvestmentPresenter(
      {final InvestmentService? investmentService,
      final BasketService? basketService})
      : _investmentService = investmentService ?? InvestmentService(),
        _basketService = basketService ?? BasketService(),
        super(CreateInvestmentViewState());

  void getBaskets() {
    _basketService.get().then(
        (value) => updateViewState((viewState) => viewState.baskets = value));
  }

  void createInvestment({int? idToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final String name = viewState.name;
    final String description = viewState.description;
    final double? value = viewState.value;
    final double? qty = viewState.qty;
    final int? basketId = viewState.basketId;
    final double? investedAmount = viewState.investedAmount;
    final DateTime? investedOn = viewState.investedOn;
    final RiskLevel riskLevel = viewState.riskLevel;
    final double? irr = viewState.irr;
    final DateTime? maturityDate = viewState.maturityDate;

    if (idToUpdate != null) {
      _investmentService
          .update(
              id: idToUpdate,
              description: description,
              name: name,
              value: value,
              qty: qty,
              basketId: basketId,
              riskLevel: riskLevel,
              irr: irr,
              maturityDate: maturityDate)
          .then((_) => updateViewState((viewState) =>
              viewState.onInvestmentCreated = SingleEvent(null)));
    } else {
      _investmentService
          .create(
              name: name,
              description: description,
              investedAmount: investedAmount!,
              investedOn: investedOn!,
              value: value,
              qty: qty,
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

  void onInvestmentAmountChanged(double? value) {
    updateViewState((viewState) => viewState.investedAmount = value);
  }

  void onInvestmentOnChanged(DateTime? time) {
    updateViewState((viewState) => viewState.investedOn = time);
  }

  void valueChanged(double? value) {
    updateViewState((viewState) {
      viewState.value = value;
      if (value != null && viewState.irr != null) {
        viewState.irr = null;
        viewState.onIRRCleared = SingleEvent(null);
      }
    });
  }

  void qtyChanged(double? qty) {
    updateViewState((viewState) => viewState.qty = qty ?? 1);
  }

  void baskedIdChanged(int baskedIt) {
    updateViewState((viewState) => viewState.basketId = baskedIt);
  }

  void riskLevelChanged(RiskLevel riskLevel) {
    updateViewState((viewState) => viewState.riskLevel = riskLevel);
  }

  void irrChanged(double? irr) {
    updateViewState((viewState) {
      viewState.irr = irr;
      if (irr != null && viewState.value != null) {
        viewState.value = null;
        viewState.onValueCleared = SingleEvent(null);
      }
    });
  }

  void setInvestment(Investment investmentToUpdate) {
    updateViewState((viewState) {
      final double? value = investmentToUpdate.irr == null
          ? investmentToUpdate.value
          : null;
      viewState.name = investmentToUpdate.name;
      viewState.description = investmentToUpdate.description?? '';
      viewState.irr = investmentToUpdate.irr;
      viewState.qty = investmentToUpdate.qty;
      viewState.investedAmount = investmentToUpdate.getTotalInvestedAmount();
      viewState.investedOn = investmentToUpdate.getLastInvestedOn();
      viewState.basketId = investmentToUpdate.basketId;
      viewState.value = value;
      viewState.riskLevel = investmentToUpdate.riskLevel;
      viewState.onInvestmentFetched = SingleEvent(null);
    });
  }

  void fetchInvestment({required int id}) {
    _investmentService
        .getBy(id: id)
        .then((investment) => setInvestment(investment));
  }

  void maturityDateChanged(DateTime? date) {
    updateViewState((viewState) => viewState.maturityDate = date);
  }
}

class CreateInvestmentViewState {
  String name = '';
  String description = '';
  int? basketId;
  double? irr;
  RiskLevel riskLevel = RiskLevel.medium;
  double? investedAmount = 0;
  DateTime? investedOn = DateTime.now();
  double? value;
  double? qty;
  DateTime? maturityDate;
  SingleEvent<void>? onInvestmentCreated;
  SingleEvent<void>? onInvestmentFetched;
  SingleEvent<void>? onIRRCleared;
  SingleEvent<void>? onValueCleared;

  List<Basket> baskets = List.empty(growable: false);

  double get totalValue {
    if (qty == 0 || qty == null) return value ?? 0;
    return (value ?? 0) * qty!;
  }

  bool isValid() {
    final value = this.value;
    final irr = this.irr;
    final containsValue = value != null;
    final containsIRR = irr != null;

    return name.isNotEmpty &&
        (containsValue || containsIRR) &&
        investedOn != null &&
        investedAmount != null;
  }
}
