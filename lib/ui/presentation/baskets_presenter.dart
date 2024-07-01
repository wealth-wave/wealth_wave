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
        .then((baskets) =>
            baskets.map((basket) => BasketVO.from(basket: basket)).toList())
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
  final String description;

  BasketVO._(
      {required this.id,
      required this.name,
      required this.description});

  factory BasketVO.from({required final Basket basket}) {
    return BasketVO._(
        id: basket.id,
        name: basket.name,
        description: basket.description ?? '');
  }
}
