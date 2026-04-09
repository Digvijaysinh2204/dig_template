import '../constants/app_config.dart';

class Endpoints {
  static String get baseUrl => AppConfig.baseUrl;
  static String get guestLogin => '$baseUrl/api/guest/register';
}
