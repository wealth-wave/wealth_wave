import 'package:wealth_wave/api/apis/basket_api.dart';
import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/basket.dart';

class CreateBasketPresenter extends Presenter<CreateBasketViewState> {
  final BasketApi _basketApi;

  CreateBasketPresenter({final BasketApi? basketApi})
      : _basketApi = basketApi ?? BasketApi(),
        super(CreateBasketViewState());

  void fetchBasket({required final int id}) {
    _basketApi
        .getBy(id: id)
        .then((basketDO) => Basket.from(basketDO: basketDO))
        .then((basket) => _setBasket(basket));
  }

  void createBasket({final int? basketId}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final String name = viewState.name;
    final String description = viewState.description;

    if (basketId != null) {
      _basketApi
          .update(id: basketId, name: name, description: description)
          .then((_) => updateViewState(
              (viewState) => viewState.onBasketCreated = SingleEvent(null)));
    } else {
      _basketApi.create(name: name, description: description).then((_) =>
          updateViewState(
              (viewState) => viewState.onBasketCreated = SingleEvent(null)));
    }
  }

  void onNameChanged(String text) {
    updateViewState((viewState) => viewState.name = text);
  }

  void onDescriptionChanged(String text) {
    updateViewState((viewState) => viewState.description = text);
  }

  void _setBasket(Basket basketToUpdate) {
    updateViewState((viewState) {
      viewState.name = basketToUpdate.name;
      viewState.description = basketToUpdate.description ?? '';
      viewState.onBasketFetched = SingleEvent(null);
    });
  }
}

class CreateBasketViewState {
  String name = '';
  String description = '';
  SingleEvent<void>? onBasketCreated;
  SingleEvent<void>? onBasketFetched;

  bool isValid() {
    return name.isNotEmpty;
  }
}
