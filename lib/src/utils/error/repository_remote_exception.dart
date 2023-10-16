class RepositoryRemoteException implements Exception {
  final String cause;

  RepositoryRemoteException(this.cause);
}