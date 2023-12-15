import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/domain/use_cases/basket/add_basket_use_case.dart';
import 'package:wealth_wave/domain/use_cases/basket/delete_basket_use_case.dart';
import 'package:wealth_wave/domain/use_cases/basket/get_baskets_use_case.dart';
import 'package:wealth_wave/domain/use_cases/basket/update_basket_use_case.dart';

class BasketsPagePresenter extends Presenter<BasketsPageViewState> {
  final AddBasketUseCase _addBasketsUseCase;
  final GetBasketsUseCase _getBasketsUseCase;
  final UpdateBasketUseCase _updateBasketsUseCase;
  final DeleteBasketUseCase _deleteBasketsUseCase;

  BasketsPagePresenter({
    GetBasketsUseCase? getBasketsUseCase,
    AddBasketUseCase? addBasketUseCase,
    UpdateBasketUseCase? updateBasketUseCase,
    DeleteBasketUseCase? deleteBasketUseCase,
  })  : _getBasketsUseCase = getBasketsUseCase ?? GetBasketsUseCase(),
        _addBasketsUseCase = addBasketUseCase ?? AddBasketUseCase(),
        _updateBasketsUseCase = updateBasketUseCase ?? UpdateBasketUseCase(),
        _deleteBasketsUseCase = deleteBasketUseCase ?? DeleteBasketUseCase(),
        super(BasketsPageViewState());

  void fetchBaskets() {
    _getBasketsUseCase.getBaskets().then((baskets) => {
          updateViewState((viewState) {
            viewState.baskets = baskets;
          })
        });
  }

  void addBasket(String name) {
    _addBasketsUseCase.addBasket(name).then((_) => fetchBaskets());
  }

  void updateBasketName(int id, String name) {
    _updateBasketsUseCase.update(id, name).then((_) => fetchBaskets());
  }

  void deleteBasket(int id) {
    _deleteBasketsUseCase.deleteBasket(id).then((_) => fetchBaskets());
  }
}

class BasketsPageViewState {
  List<Basket> baskets = [];

  BasketsPageViewState({this.baskets = const []});
}
