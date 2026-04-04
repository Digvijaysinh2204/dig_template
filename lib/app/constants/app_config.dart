import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../firebase_options.dart';
enum Environment { live, staging, debug }
class AppConfig {
  AppConfig._();
  static Environment _currentEnvironment = Environment.debug;
  static Environment get currentEnvironment => _currentEnvironment;
  static void setEnvironment(Environment env) {
    _currentEnvironment = env;
  }
  static bool get isLive => _currentEnvironment == Environment.live;
  static String get baseUrl {
    switch (_currentEnvironment) {
      case Environment.live:
        return dotenv.get('BASE_URL_LIVE', fallback: 'https://api.live.com');
      case Environment.staging:
        return dotenv.get(
          'BASE_URL_STAGING',
          fallback: 'https://api.staging.com',
        );
      case Environment.debug:
        return dotenv.get('BASE_URL_DEBUG', fallback: 'http://localhost:3000');
    }
  }
  static bool get encrypt {
    switch (_currentEnvironment) {
      case Environment.live:
      case Environment.staging:
        return true;
      case Environment.debug:
        return false;
    }
  }
  static FirebaseOptions? get firebaseOptions {
    try {
      final options = DefaultFirebaseOptions.currentPlatform;
      if (options.projectId.isEmpty) return null;
      return options;
    } catch (_) {
      return null;
    }
  }
}
