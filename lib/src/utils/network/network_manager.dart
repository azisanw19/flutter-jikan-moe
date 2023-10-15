import 'dart:async';

abstract class NetworkManager {

  Stream<bool> get watchIsOnline;

  Future<bool> get isOnline;

}