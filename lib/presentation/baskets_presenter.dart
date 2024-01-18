import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/domain/services/basket_service.dart';

class BasketsPresenter extends Presenter<BasketsViewState> {
  final BasketService _basketService;

  BasketsPresenter({final BasketService? basketService})
      : _basketService = basketService ?? BasketService(),
        super(BasketsViewState());

  void fetchBaskets() {
    _basketService
        .get()
        .then((baskets) => Future.wait(baskets.map((basket) => Future.wait([
              basket.getTotalInvestments(),
              basket.getInvestedValue(),
            ]).then((results) => BasketVO.from(basket: basket)))))
        .then((basketVOs) =>
            updateViewState((viewState) => viewState.baskets = basketVOs));
  }

  void deleteBasket({required final int id}) {
    _basketService.deleteBy(id: id).then((_) => fetchBaskets());
  }
}

class BasketsViewState {
  List<BasketVO> baskets = [];
}

class BasketVO {
  final int id;
  final String name;
  final String? description;
  final double totalInvestedAmount;
  final int totalInvesments;

  BasketVO(
      {required this.totalInvestedAmount,
      required this.totalInvesments,
      required this.id,
      required this.name,
      required this.description});

  static Future<BasketVO> from({required final Basket basket}) async {
    return BasketVO(
        id: basket.id,
        name: basket.name,
        description: basket.description,
        totalInvestedAmount: await basket.getInvestedValue(),
        totalInvesments: await basket.getTotalInvestments());
  }
}
