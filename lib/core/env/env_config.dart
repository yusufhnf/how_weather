import 'package:envied/envied.dart';

part 'env_config.g.dart';

///Required Environment
///Available env params:
/// - `prod` for production
/// - `dev` for development
/// - `staging` for testing
const currentEnv = "prod";

@Envied(path: '.env')
abstract class Env {
  @EnviedField(obfuscate: true, varName: 'WEATHER_API_KEY')
  static String weatherApiKey = _Env.weatherApiKey;
}
