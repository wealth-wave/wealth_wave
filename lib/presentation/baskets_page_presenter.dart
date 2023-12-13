import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/domain/use_cases/add_basket_use_case.dart';
import 'package:wealth_wave/domain/use_cases/get_baskets_use_case.dart';

class BasketsPagePresenter extends Presenter<BasketsPageViewState> {
  final GetBasketsUseCase _getBasketsUseCase;
  final AddBasketUseCase _addBasketsUseCase;

  BasketsPagePresenter(
      {GetBasketsUseCase? getBasketsUseCase,
      AddBasketUseCase? addBasketUseCase})
      : _getBasketsUseCase = getBasketsUseCase ?? GetBasketsUseCase(),
        _addBasketsUseCase = addBasketUseCase ?? AddBasketUseCase(),
        super(BasketsPageViewState());

  void fetchBaskets() {
    _getBasketsUseCase.getBaskets().then((baskets) => {
          updateViewState((viewState) {
            viewState.baskets = [];
          })
        });
  }

  void addBasket(String name) {
    _addBasketsUseCase.addBasket(name).then((_) => fetchBaskets());
  }
}

class BasketsPageViewState {
  List<Basket> baskets = [];

  BasketsPageViewState({this.baskets = const []});
}
