class RepositoryLocalException implements Exception {
  final String cause;

  RepositoryLocalException(this.cause);
}