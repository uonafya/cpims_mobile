import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isConnected = false;
  Future<bool> checkInternetConnection() async {
    bool connectivityResult = await InternetConnection().hasInternetAccess;

    if (connectivityResult) {
      // Device is connected to a mobile/wifi network.
      _isConnected = true;
    } else {
      // Device is offline
      _isConnected = false;
    }
    notifyListeners();
    return _isConnected;
  }

  bool get isConnected => _isConnected;
}
