import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/services/investment_service.dart';
import 'package:wealth_wave/ui/models/investment_vo.dart';

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
            .where((element) => element.qty > 0)
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

enum SortBy {
  name,
  value,
  irr,
}

enum SortByDirection {
  ascending,
  descending,
}
