import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/api/db/app_database.dart';
import 'package:wealth_wave/core/presenter.dart';

class BasketsPagePresenter extends Presenter<BasketsPageViewState> {
  final BasketApi _basketApi;

  BasketsPagePresenter({final BasketApi? basketApi})
      : _basketApi = basketApi ?? BasketApi(),
        super(BasketsPageViewState());

  void fetchBaskets() {
    _basketApi.getBaskets().then((baskets) => updateViewState((viewState) {
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
    _basketApi.deleteBasket(id: id).then((_) => null);
  }
}

class BasketsPageViewState {
  List<Basket> baskets = [];
}
