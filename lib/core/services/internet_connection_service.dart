import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../core.dart';

@lazySingleton
class InternetConnectionService {
  final InternetConnection _internetConnection;

  InternetConnectionService({required InternetConnection internetConnection})
    : _internetConnection = internetConnection;

  Future<void> get hasConnection async {
    try {
      final isConnected = await _internetConnection.hasInternetAccess;
      if (isConnected) {
        return;
      } else {
        throw const ConnectionException();
      }
    } on Exception catch (e) {
      throw ConnectionException(e.toString());
    }
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
