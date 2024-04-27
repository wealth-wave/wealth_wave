import 'package:wealth_wave/contract/risk_level.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/models/sip.dart';
import 'package:wealth_wave/domain/models/transaction.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';

class InvestmentsPresenter extends Presenter<InvestmentsViewState> {
  final InvestmentService _investmentService;

  InvestmentsPresenter({final InvestmentService? investmentService})
      : _investmentService = investmentService ?? InvestmentService(),
        super(InvestmentsViewState());

  void fetchInvestments() {
    _investmentService
        .get()
        .then((investments) => investments
            .map((investment) => InvestmentVO.from(investment: investment))
            .toList())
        .then((investmentVOs) {
      investmentVOs.sort((a, b) => a.currentValue > b.currentValue ? -1 : 1);
      updateViewState((viewState) {
        viewState.unfilteredInvestmentVOs = investmentVOs;
      });
    });
  }

  void updateValues() {
    updateViewState((viewState) {
      viewState.updatingValues = true;
    });
    _investmentService.updateValues().then((value) {
      fetchInvestments();
      updateViewState((viewState) {
        viewState.updatingValues = false;
      });
    });
  }

  void updateValue({required final int investmentId}) {
    updateViewState((viewState) {
      viewState.updatingValues = true;
    });
    _investmentService.updateValue(investmentId: investmentId).then((value) {
      fetchInvestments();
      updateViewState((viewState) {
        viewState.updatingValues = false;
      });
    });
  }

  void deleteInvestment({required final int id}) {
    _investmentService.deleteBy(id: id).then((value) => fetchInvestments());
  }

  void filterByName(String value) {
    updateViewState((viewState) {
      viewState.filterText = value;
    });
  }

  void sortBy(
      {required final SortBy sortBy}) {
    updateViewState((viewState) {
      viewState.sortBy = sortBy;
      viewState.sortByDirection = sortBy == SortBy.name
          ? SortByDirection.ascending
          : SortByDirection.descending;
    });
  }
}

class InvestmentsViewState {
  List<InvestmentVO> unfilteredInvestmentVOs = [];
  SortBy sortBy = SortBy.name;
  SortByDirection sortByDirection = SortByDirection.ascending;
  String filterText = '';
  bool updatingValues = false;

  List<InvestmentVO> get investmentVOs {
    List<InvestmentVO> investments = unfilteredInvestmentVOs
        .where((investmentVO) =>
            filterText.isEmpty ||
            investmentVO.name.toLowerCase().contains(filterText.toLowerCase()))
        .toList();
    if (sortBy == SortBy.name) {
      if (sortByDirection == SortByDirection.ascending) {
        investments.sort((a, b) => a.name.compareTo(b.name));
      } else {
        investments.sort((a, b) => a.name.compareTo(b.name));
      }
    } else if (sortBy == SortBy.value) {
      if (sortByDirection == SortByDirection.ascending) {
        investments.sort((a, b) => a.currentValue > b.currentValue ? 1 : -1);
      } else {
        investments.sort((a, b) => a.currentValue > b.currentValue ? -1 : 1);
      }
    } else if (sortBy == SortBy.irr) {
      if (sortByDirection == SortByDirection.ascending) {
        investments.sort((a, b) => a.irr > b.irr ? 1 : -1);
      } else {
        investments.sort((a, b) => a.irr > b.irr ? -1 : 1);
      }
    }
    return investments;
  }
}

class InvestmentVO {
  final int id;
  final String name;
  final String? description;
  final RiskLevel riskLevel;
  final double irr;
  final double investedValue;
  final double currentValue;
  final DateTime? maturityDate;
  final int? basketId;
  final String? basketName;
  final List<Sip> sips;
  final List<Transaction> transactions;
  final int taggedGoalCount;
  final bool hasScript;

  int get transactionCount => transactions.length;

  int get sipCount => sips.length;

  InvestmentVO._(
      {required this.id,
      required this.name,
      required this.description,
      required this.riskLevel,
      required this.irr,
      required this.basketId,
      required this.basketName,
      required this.investedValue,
      required this.currentValue,
      required this.maturityDate,
      required this.transactions,
      required this.sips,
      required this.hasScript,
      required this.taggedGoalCount});

  factory InvestmentVO.from({required final Investment investment}) {
    return InvestmentVO._(
        id: investment.id,
        name: investment.name,
        description: investment.description,
        riskLevel: investment.riskLevel,
        irr: investment.getIRR(),
        investedValue: investment.getTotalInvestedAmount(),
        currentValue: investment.getValueOn(date: DateTime.now()),
        basketId: investment.basketId,
        basketName: investment.basketName,
        transactions: investment.transactions,
        sips: investment.sips,
        taggedGoalCount: investment.goalsCount,
        hasScript: investment.script != null,
        maturityDate: investment.maturityDate);
  }
}

enum SortBy {
  name,
  value,
  irr,
}

enum SortByDirection {
  ascending,
  descending,
}
