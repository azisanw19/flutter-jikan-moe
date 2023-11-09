abstract class DataState<T> {
  final T? data;
  final Exception? exception;

  const DataState({this.data, this.exception});
}

class DataStateSuccess<T> extends DataState<T> {
  const DataStateSuccess(T data) : super(data: data);
}

class DataStateError<T> extends DataState<T> {
  const DataStateError(Exception exception) : super(exception: exception);
}