import 'dart:async';

import 'package:anime_list/src/utils/network/network_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityManager implements NetworkManager {

  final Connectivity connectivity = Connectivity();

  @override
  Stream<bool> get watchIsOnline => connectivity.onConnectivityChanged.map(_internetCheck);

  @override
  Future<bool> get isOnline async => _internetCheck(await connectivity.checkConnectivity());

  bool _internetCheck(ConnectivityResult connectivityResult) {
    switch(connectivityResult) {
      case ConnectivityResult.mobile: {
        return true;
      }
      case ConnectivityResult.wifi: {
        return true;
      }
      default: {
        return false;
      }
    }
  }

}
