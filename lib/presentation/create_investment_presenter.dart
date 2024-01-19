import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/services/basket_service.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';
import 'package:wealth_wave/utils/ui_utils.dart';
import 'package:wealth_wave/utils/utils.dart';

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
      _investmentService
          .update(
              id: investmentIdToUpdate,
              description: description,
              name: name,
              value: double.tryParse(value!),
              valueUpdatedOn: valueUpdatedAt,
              basketId: basketId,
              riskLevel: riskLevel,
              irr: double.tryParse(irr!),
              maturityDate: maturityDate)
          .then((_) => updateViewState((viewState) =>
              viewState.onInvestmentCreated = SingleEvent(null)));
    } else {
      _investmentService
          .create(
              name: name,
              description: description,
              value: double.tryParse(value!),
              valueUpdatedOn: valueUpdatedAt,
              basketId: basketId,
              riskLevel: riskLevel,
              irr: double.tryParse(irr!),
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
    updateViewState((viewState) {
      viewState.value = text;
      if (text.isNotEmpty) {
        viewState.irr = null;
        viewState.onIRRCleared = SingleEvent(null);
      }
    });
  }

  void valueUpdatedDateChanged(String date) {
    updateViewState((viewState) {
      viewState.valueUpdatedAt = date;
      if (date.isNotEmpty && viewState.irr != null) {
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

  void irrChanged(String irr) {
    updateViewState((viewState) {
      viewState.irr = irr;
      if (irr.isNotEmpty &&
          (viewState.value != null || viewState.valueUpdatedAt != null)) {
        viewState.valueUpdatedAt = '';
        viewState.value = null;
        viewState.onValueCleared = SingleEvent(null);
      }
    });
  }

  void setInvestment(Investment investmentToUpdate) {
    updateViewState((viewState) {
      viewState.name = investmentToUpdate.name;
      viewState.basketId = investmentToUpdate.basketId;
      viewState.value = investmentToUpdate.value != null
          ? formatDecimal(investmentToUpdate.value!)
          : null;
      viewState.valueUpdatedAt = investmentToUpdate.valueUpdatedOn != null
          ? formatDate(investmentToUpdate.valueUpdatedOn!)
          : null;
      viewState.riskLevel = investmentToUpdate.riskLevel;
      viewState.onInvestmentFetched = SingleEvent(null);
    });
  }

  void fetchInvestment({required int id}) {
    _investmentService
        .getBy(id: id)
        .then((investment) => setInvestment(investment));
  }
}

class CreateInvestmentViewState {
  String name = '';
  String description = '';
  int? basketId;
  String? irr;
  RiskLevel riskLevel = RiskLevel.medium;
  String? value;
  String? valueUpdatedAt;
  String? maturityDate;
  SingleEvent<void>? onInvestmentCreated;
  SingleEvent<void>? onInvestmentFetched;
  SingleEvent<void>? onIRRCleared;
  SingleEvent<void>? onValueCleared;

  List<Basket> baskets = List.empty(growable: false);

  bool isValid() {
    final valueAsDouble = double.tryParse(value ?? '');
    final irrAsDouble = double.tryParse(irr ?? '');
    final valueUpdateAtAsDate = parseDate(valueUpdatedAt ?? '');

    final containsValue = valueAsDouble != null &&
        valueAsDouble > 0 &&
        valueUpdateAtAsDate != null;
    final containsIRR = irrAsDouble != null && irrAsDouble > 0;

    return name.isNotEmpty && (containsValue || containsIRR);
  }

  DateTime? _getValueUpdatedAt() {
    return valueUpdatedAt != null ? parseDate(valueUpdatedAt!) : null;
  }

  DateTime? getMaturityDate() {
    return maturityDate != null ? parseDate(maturityDate!) : null;
  }
}
