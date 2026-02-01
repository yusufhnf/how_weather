import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';

@lazySingleton
class LoggerService {
  final Talker _talker;

  LoggerService({required Talker talker}) : _talker = talker;

  Talker get talker => _talker;

  void debug(String message, [dynamic exception, StackTrace? stackTrace]) {
    _talker.debug(message);
    if (exception != null) {
      _talker.handle(exception, stackTrace);
    }
  }

  void info(String message) {
    _talker.info(message);
  }

  void warning(String message, [dynamic exception, StackTrace? stackTrace]) {
    _talker.warning(message);
    if (exception != null) {
      _talker.handle(exception, stackTrace);
    }
  }

  void error(String message, [dynamic exception, StackTrace? stackTrace]) {
    _talker.error(message);
    if (exception != null) {
      _talker.handle(exception, stackTrace);
    }
  }

  void critical(String message, [dynamic exception, StackTrace? stackTrace]) {
    _talker.critical(message);
    if (exception != null) {
      _talker.handle(exception, stackTrace);
    }
  }

  void log(String message) {
    _talker.log(message);
  }

  void handle(dynamic exception, [StackTrace? stackTrace]) {
    _talker.handle(exception, stackTrace);
  }
}
