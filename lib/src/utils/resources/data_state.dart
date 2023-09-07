abstract class DataState<T> {
  final T? data;
  final Exception? exception;

  const DataState({this.data, this.exception});
}

class Success<T> extends DataState<T> {
  const Success(T data) : super(data: data);
}

class Error<T> extends DataState<T> {
  const Error(Exception exception) : super(exception: exception);
}

class Loading<T> extends DataState<T> {
  const Loading();
}