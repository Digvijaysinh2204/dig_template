import '../module/module_export.dart';
import '../module/test_detail/test_detail_binding.dart';
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
    GetPage(
      name: AppRoute.otp,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: AppRoute.registerView,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoute.main,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/TestDetail/:id',
      page: () => const TestDetailView(),
      binding: TestDetailBinding(),
      preventDuplicates: false,
    ),
  ];
}
