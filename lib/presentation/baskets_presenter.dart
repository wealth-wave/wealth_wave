import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/domain/usecases/fetch_baskets_use_case.dart';

class BasketsPresenter extends Presenter<BasketsViewState> {
  final FetchBasketsUseCase _fetchBasketsUseCase;
  final BasketApi _basketApi;

  BasketsPresenter(
      {final FetchBasketsUseCase? fetchBasketsUseCase,
      final BasketApi? basketApi})
      : _fetchBasketsUseCase = fetchBasketsUseCase ?? FetchBasketsUseCase(),
        _basketApi = basketApi ?? BasketApi(),
        super(BasketsViewState());

  void fetchBaskets() {
    _fetchBasketsUseCase
        .invoke()
        .then((baskets) => updateViewState((viewState) {
              viewState.baskets = baskets;
            }));
  }

  void createBasket({required final String name}) {
    _basketApi.createBasket(name: name).then((_) => fetchBaskets());
  }

  void updateBasketName({required final int id, required final String name}) {
    _basketApi.updateName(id: id, name: name).then((_) => fetchBaskets());
  }

  void deleteBasket({required final int id}) {
    _basketApi.deleteBasket(id: id).then((_) => fetchBaskets());
  }
}

class BasketsViewState {
  List<Basket> baskets = [];
}
