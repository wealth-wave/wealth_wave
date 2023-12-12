class SingleEvent<T> {
  final T content;

  bool _isConsumed = false;

  SingleEvent(this.content);

  void consume(Function(T) action) {
    if (!_isConsumed) {
      _isConsumed = true;
      action(content);
    }
  }

  T? consumeGet() {
    if (!_isConsumed) {
      _isConsumed = true;
      return content;
    }
    return null;
  }

  void reset() {
    _isConsumed = false;
  }

  T peekContent() {
    return content;
  }
}
