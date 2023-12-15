import 'dart:ui';

import 'package:wealth_wave/core/single_event.dart';


class ViewStateHolder<T> {
  SingleEvent<ErrorHolder>? errorEvent;
  SingleEvent<String?>? loadingEvent;
  T viewState;

  ViewStateHolder(this.viewState);

  void setError({required String error, VoidCallback? retry}) {
    errorEvent = SingleEvent(ErrorHolder(errorMessage: error, onRetry: retry));
  }

  void setLoading({final String? message}) {
    loadingEvent = SingleEvent(message);
  }

  void updateViewState(final T viewState) {
    this.viewState = viewState;
  }
}

class ErrorHolder {
  final String errorMessage;
  final VoidCallback? onRetry;

  ErrorHolder({required this.errorMessage, this.onRetry});
}
