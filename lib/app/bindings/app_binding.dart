import '../utils/import.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // 1. Immediate initialization (Only for base app configuration)
    Get.put<StorageService>(StorageService(), permanent: true);
    Get.put<LanguageService>(LanguageService(), permanent: true);
    Get.put<ThemeService>(ThemeService(), permanent: true);

    // 2. Lazy initialization (Zero memory until used)
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<UserService>(() => UserService(), fenix: true);
    Get.lazyPut<NetworkService>(() => NetworkService(), fenix: true);
    Get.lazyPut<AppLoadingService>(() => AppLoadingService(), fenix: true);
    Get.lazyPut<ToastService>(() => ToastService(), fenix: true);
    
    // Utilities (Always Lazy)
    Get.lazyPut<CryptoService>(() => CryptoService(), fenix: true);
    Get.lazyPut<DeviceInfoService>(() => DeviceInfoService(), fenix: true);
    Get.lazyPut<TimezoneService>(() => TimezoneService(), fenix: true);
    Get.lazyPut<AnalyticsService>(() => AnalyticsService(), fenix: true);
    Get.lazyPut<MediaService>(() => MediaService(), fenix: true);

    if (AppConstant.isFirebaseEnabled) {
      Get.lazyPut<CrashlyticsService>(() => CrashlyticsService(), fenix: true);
      Get.lazyPut<NotificationService>(() => NotificationService(), fenix: true);
      Get.lazyPut<DownloadService>(() => DownloadService(), fenix: true);
    }
  }
}
