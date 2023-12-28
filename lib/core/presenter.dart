import 'dart:async';
import 'dart:ui';

import 'package:wealth_wave/core/view_state_holder.dart';

typedef UpdateViewStateFunction<T> = void Function(T viewState);

abstract class Presenter<T> {
  final ViewStateHolder<T> _viewStateHolder;
  final StreamController<ViewStateHolder<T>> _viewStateController =
  StreamController();

  Presenter(final T viewState) : _viewStateHolder = ViewStateHolder(viewState) {
    _viewStateController.sink.add(_viewStateHolder);
  }

  Stream<ViewStateHolder<T>> getViewStateStream() {
    return _viewStateController.stream;
  }

  void updateViewState(UpdateViewStateFunction<T> update,
      {bool notify = true}) {
    update(_viewStateHolder.viewState);
    if (notify) {
      _viewStateController.sink.add(_viewStateHolder);
    }
  }

  void setLoading({final String? message}) {
    _viewStateHolder.setLoading(message: message);
    _viewStateController.sink.add(_viewStateHolder);
  }

  void setError({required final String error, final VoidCallback? onRetry}) {
    _viewStateHolder.setError(error: error, retry: onRetry);
    _viewStateController.sink.add(_viewStateHolder);
  }

  T getViewState() {
    return _viewStateHolder.viewState;
  }

  onDestroy() {
    _viewStateController.sink.close();
  }
}
