class UseCaseException implements Exception {
  final String cause;

  UseCaseException(this.cause);
}