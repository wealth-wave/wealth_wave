import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/apis/investment_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/basket.dart';

class FetchBasketsUseCase {
  final BasketApi _basketApi;
  final InvestmentApi _investmentApi;

  FetchBasketsUseCase({BasketApi? basketApi, InvestmentApi? investmentApi})
      : _basketApi = basketApi ?? BasketApi(),
        _investmentApi = investmentApi ?? InvestmentApi();

  Future<List<Basket>> invoke() async {
    List<BasketDO> baskets = await _basketApi.getBaskets();
    List<InvestmentDO> investments = await _investmentApi.getInvestments();

    return baskets.map((basket) {
      List<InvestmentDO> investmentsOfBasket = investments
          .where((investment) => investment.basketId == basket.id)
          .toList();

      return Basket.from(basket: basket, investments: investmentsOfBasket);
    }).toList();
  }
}
