import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/domain/use_cases/basket/create_basket_use_case.dart';
import 'package:wealth_wave/domain/use_cases/basket/delete_basket_use_case.dart';
import 'package:wealth_wave/domain/use_cases/basket/get_baskets_use_case.dart';
import 'package:wealth_wave/domain/use_cases/basket/update_basket_use_case.dart';

class BasketsPagePresenter extends Presenter<BasketsPageViewState> {
  final CreateBasketUseCase _createBasketsUseCase;
  final GetBasketsUseCase _getBasketsUseCase;
  final UpdateBasketUseCase _updateBasketsUseCase;
  final DeleteBasketUseCase _deleteBasketsUseCase;

  BasketsPagePresenter({
    final GetBasketsUseCase? getBasketsUseCase,
    final CreateBasketUseCase? createBasketUseCase,
    final UpdateBasketUseCase? updateBasketUseCase,
    final DeleteBasketUseCase? deleteBasketUseCase,
  })  : _getBasketsUseCase = getBasketsUseCase ?? GetBasketsUseCase(),
        _createBasketsUseCase = createBasketUseCase ?? CreateBasketUseCase(),
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

  void createBasket({required final String name}) {
    _createBasketsUseCase.createBasket(name: name).then((_) => fetchBaskets());
  }

  void updateBasketName({required final int id, required final String name}) {
    _updateBasketsUseCase
        .update(id: id, name: name)
        .then((_) => fetchBaskets());
  }

  void deleteBasket({required final int id}) {
    _deleteBasketsUseCase.deleteBasket(id: id).then((_) => fetchBaskets());
  }
}

class BasketsPageViewState {
  List<Basket> baskets = [];
}
