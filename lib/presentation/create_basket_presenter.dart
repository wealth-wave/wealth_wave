import 'package:wealth_wave/core/presenter.dart';
import 'package:wealth_wave/core/single_event.dart';
import 'package:wealth_wave/domain/models/basket.dart';
import 'package:wealth_wave/domain/services/basket_service.dart';

class CreateBasketPresenter extends Presenter<CreateBasketViewState> {
  final BasketService _basketService;

  CreateBasketPresenter({final BasketService? basketService})
      : _basketService = basketService ?? BasketService(),
        super(CreateBasketViewState());

  void fetchBasket({required final int id}) {
    _basketService.getById(id: id).then((basket) => _setBasket(basket));
  }

  void createBasket({final int? idToUpdate}) {
    var viewState = getViewState();

    if (!viewState.isValid()) {
      return;
    }

    final String name = viewState.name;
    final String description = viewState.description;

    if (idToUpdate != null) {
      _basketService
          .update(id: idToUpdate, name: name, description: description)
          .then((_) => updateViewState(
              (viewState) => viewState.onBasketCreated = SingleEvent(null)));
    } else {
      _basketService.create(name: name, description: description).then((_) =>
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
