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

  void setLoading({String? message}) {
    loadingEvent = SingleEvent(message);
  }

  void updateViewState(T viewState) {
    this.viewState = viewState;
  }
}

class ErrorHolder {
  String errorMessage;
  VoidCallback? onRetry;

  ErrorHolder({required this.errorMessage, this.onRetry});
}
