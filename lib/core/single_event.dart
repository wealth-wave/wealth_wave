class SingleEvent<T> {
  final T _content;

  bool _isConsumed = false;

  SingleEvent(this._content);

  void consume(Function(T) action) {
    if (!_isConsumed) {
      _isConsumed = true;
      action(_content);
    }
  }

  T? consumeGet() {
    if (!_isConsumed) {
      _isConsumed = true;
      return _content;
    }
    return null;
  }

  void reset() {
    _isConsumed = false;
  }

  T peekContent() {
    return _content;
  }
}
