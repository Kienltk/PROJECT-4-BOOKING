import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:staynia/core/log.dart';

class NetworkObserver {
  static final Connectivity _connectivity = Connectivity();
  //* Todo
  static void listenNetwork() {
    _connectivity.onConnectivityChanged.listen((results) {
      final primary = results.firstOrNull;
      if (primary == null || primary == ConnectivityResult.none) {
        // NotificationService.showNotification('Không có kết nối internet');
      } else {
        Log.d('$primary', name: 'Network LOG');
      }
    });
  }
}
