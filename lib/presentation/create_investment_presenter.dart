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
    final DateTime? valueUpdatedAt = viewState.valueUpdatedAt;
    final int? basketId = viewState.basketId;
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
              valueUpdatedOn: valueUpdatedAt,
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
              value: value,
              valueUpdatedOn: valueUpdatedAt,
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

  void valueChanged(double? value) {
    updateViewState((viewState) {
      viewState.value = value;
      if (value != null && viewState.irr != null) {
        viewState.irr = null;
        viewState.onIRRCleared = SingleEvent(null);
      }
    });
  }

  void valueUpdatedDateChanged(DateTime? date) {
    updateViewState((viewState) {
      viewState.valueUpdatedAt = date;
      if (date != null && viewState.irr != null) {
        viewState.irr = null;
        viewState.onIRRCleared = SingleEvent(null);
      }
    });
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
      if (irr != null &&
          (viewState.value != null || viewState.valueUpdatedAt != null)) {
        viewState.valueUpdatedAt = null;
        viewState.value = null;
        viewState.onValueCleared = SingleEvent(null);
      }
    });
  }

  void setInvestment(Investment investmentToUpdate) {
    updateViewState((viewState) {
      final DateTime? valueUpdatedOn = investmentToUpdate.valueUpdatedOn;
      final double? value = investmentToUpdate.value;
      viewState.name = investmentToUpdate.name;
      viewState.basketId = investmentToUpdate.basketId;
      viewState.value = value;
      viewState.valueUpdatedAt = valueUpdatedOn;
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
  double? value;
  DateTime? valueUpdatedAt = DateTime.now();
  DateTime? maturityDate;
  SingleEvent<void>? onInvestmentCreated;
  SingleEvent<void>? onInvestmentFetched;
  SingleEvent<void>? onIRRCleared;
  SingleEvent<void>? onValueCleared;

  List<Basket> baskets = List.empty(growable: false);

  bool isValid() {
    final value = this.value;
    final irr = this.irr;
    final containsValue = value != null && value > 0 && valueUpdatedAt != null;
    final containsIRR = irr != null && irr > 0;

    return name.isNotEmpty && (containsValue || containsIRR);
  }
}
