class DatabaseException implements Exception {
  final String cause;

  DatabaseException(this.cause);
}