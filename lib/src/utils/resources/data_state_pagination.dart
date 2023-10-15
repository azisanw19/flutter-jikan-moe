abstract class DataStatePagination<T, R> {
  final T? data;
  final R? pagination;
  final Exception? exception;

  const DataStatePagination({this.data, this.exception, this.pagination});
}

class DataStatePaginationSuccess<T, R> extends DataStatePagination<T, R> {
  const DataStatePaginationSuccess(T data) : super(data: data);
}

class DataStatePaginationError<T, R> extends DataStatePagination<T, R> {
  const DataStatePaginationError(Exception exception) : super(exception: exception);
}

class DataStatePaginationLoading<T, R> extends DataStatePagination<T, R> {
  const DataStatePaginationLoading();
}
