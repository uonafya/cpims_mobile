import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isConnected = false;
  Future<bool> checkInternetConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Device is connected to a mobile/wifi network.
      _isConnected = true;
    } else if (connectivityResult == ConnectivityResult.none) {
      // Device is offline
      _isConnected = false;
    }
    notifyListeners();
    return _isConnected;
  }

  bool get isConnected => _isConnected;
}
