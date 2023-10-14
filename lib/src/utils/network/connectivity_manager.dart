import 'dart:async';

import 'package:anime_list/src/utils/network/network_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityManager implements NetworkManager {

  @override
  Stream<bool> isOnline = Connectivity().onConnectivityChanged.map((connectivityResult) {
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
  });



}
