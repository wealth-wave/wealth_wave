import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/domain/models/investment.dart';
import 'package:wealth_wave/domain/usecases/fetch_investments_use_case.dart';

class FetchBasketsUseCase {
  final BasketApi _basketApi;
  final FetchInvestmentsUseCase _fetchInvestmentsUseCase;

  FetchBasketsUseCase(
      {BasketApi? basketApi, FetchInvestmentsUseCase? fetchInvestmentsUseCase})
      : _basketApi = basketApi ?? BasketApi(),
        _fetchInvestmentsUseCase =
            fetchInvestmentsUseCase ?? FetchInvestmentsUseCase();

  Future<List<Basket>> invoke() async {
    List<BasketDO> baskets = await _basketApi.get();
    List<Investment> investments =
        await _fetchInvestmentsUseCase.fetchInvestments();

    return baskets.map((basket) {
      List<Investment> investmentsOfBasket = investments
          .where((investment) => investment.basketId == basket.id)
          .toList();

      return Basket.from(basket: basket, investments: investmentsOfBasket);
    }).toList();
  }
}
