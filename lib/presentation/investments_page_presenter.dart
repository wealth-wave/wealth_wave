import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';

class InvestmentsPagePresenter extends Presenter<InvestmentsPageViewState> {
  final InvestmentApi _investmentApi;
  final BasketApi _basketApi;

  InvestmentsPagePresenter(
      {final InvestmentApi? investmentApi, final BasketApi? basketApi})
      : _investmentApi = investmentApi ?? InvestmentApi(),
        _basketApi = basketApi ?? BasketApi(),
        super(InvestmentsPageViewState());

  void fetchInvestments() {
    _investmentApi
        .getInvestments()
        .listen((investments) => updateViewState((viewState) {
              viewState._addInvestments(investments);
            }));

    _investmentApi
        .getTransactions()
        .listen((transactions) => updateViewState((viewState) {
              viewState._addTransaction(transactions);
            }));

    _basketApi.getBaskets().listen((baskets) => updateViewState((viewState) {
          viewState._updateBasketInfo(baskets);
        }));
  }

  void deleteInvestment({required final int id}) {
    _investmentApi.deleteInvestment(id: id).then((value) => null);
  }
}

class InvestmentsPageViewState {
  List<InvestmentVO> investments = [];

  void _addInvestments(final List<Investment> investmentsToAdd) {
    for (var investment in investmentsToAdd) {
      InvestmentVO? investmentVO = investments.cast<InvestmentVO?>().firstWhere(
          (element) => element!.investment.id == investment.id,
          orElse: () => null);
      if (investmentVO == null) {
        investments.add(InvestmentVO(
            investment: investment,
            transactions: [],
            basket: const Basket(id: 0, name: 'Loading...')));
      }
    }
  }

  void _updateBasketInfo(final List<Basket> baskets) {
    for (var investmentVO in investments) {
      investmentVO.basket = baskets.firstWhere(
          (element) => element.id == investmentVO.investment.basketId);
    }
  }

  void _addTransaction(final List<InvestmentTransaction> transactions) {
    Map<int, List<InvestmentTransaction>> transactionsMap = transactions
        .fold(<int, List<InvestmentTransaction>>{},
            (Map<int, List<InvestmentTransaction>> map, transaction) {
      if (map.containsKey(transaction.investmentId)) {
        map[transaction.investmentId]!.add(transaction);
      } else {
        map[transaction.investmentId] = [transaction];
      }
      return map;
    });

    for (var investmentVO in investments) {
      investmentVO.transactions = transactionsMap[investmentVO.investment.id] ??
          investmentVO.transactions;
    }
  }
}

class InvestmentVO {
  Investment investment;
  Basket basket;
  List<InvestmentTransaction> transactions;

  InvestmentVO({
    required this.investment,
    required this.transactions,
    required this.basket,
  });
}
