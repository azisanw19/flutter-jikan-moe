class RuntimeException implements Exception {
  final String cause;

  RuntimeException(this.cause);
}