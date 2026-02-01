import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

@lazySingleton
class InternetConnectionService {
  final InternetConnection _internetConnection;

  InternetConnectionService(this._internetConnection);

  Future<bool> get hasConnection async {
    return await _internetConnection.hasInternetAccess;
  }

  Stream<InternetStatus> get onStatusChange {
    return _internetConnection.onStatusChange;
  }

  Future<InternetStatus> get internetStatus async {
    return await _internetConnection.hasInternetAccess
        ? InternetStatus.connected
        : InternetStatus.disconnected;
  }
}
