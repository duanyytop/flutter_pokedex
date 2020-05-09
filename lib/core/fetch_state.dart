class FetchState {
  final bool canLoadMore;

  const FetchState(this.canLoadMore);
}

class NoInternetState extends FetchState {
  const NoInternetState() : super(false);
}

class InitialState extends FetchState {
  const InitialState() : super(true);
}

class EmptyState extends FetchState {
  const EmptyState() : super(false);
}

class SuccessState<T> extends FetchState {
  const SuccessState(this.data, {bool canLoadMore = true}) : super(canLoadMore);

  final T data;
}

class ErrorState<E extends Exception> extends FetchState {
  const ErrorState(this.error) : super(false);

  final E error;
}
