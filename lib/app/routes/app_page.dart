import '../module/module_export.dart';
import '../utils/import.dart';

abstract class AppPage {
  AppPage._();
  static const String initial = AppRoute.splash;
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoute.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoute.auth,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
  ];
}
