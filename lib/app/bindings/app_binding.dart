import '../utils/import.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Get.put<CryptoService>(CryptoService(), permanent: true);
    Get.put<StorageService>(StorageService(), permanent: true);
    Get.put<ApiService>(ApiService(), permanent: true);
    Get.put<LanguageService>(LanguageService(), permanent: true);
    Get.put<DeviceInfoService>(DeviceInfoService(), permanent: true);
    Get.put<TimezoneService>(TimezoneService(), permanent: true);
    Get.put<NetworkService>(NetworkService(), permanent: true);
    Get.put<ThemeService>(ThemeService(), permanent: true);
    Get.put<AppLoadingService>(AppLoadingService(), permanent: true);
    Get.put<AnalyticsService>(AnalyticsService(), permanent: true);
    Get.put<ToastService>(ToastService(), permanent: true);
    Get.put<UserService>(UserService(), permanent: true);
    if (AppConstant.isFirebaseEnabled) {
      Get.put<CrashlyticsService>(CrashlyticsService(), permanent: true);
      Get.put<NotificationService>(NotificationService(), permanent: true);
      Get.put<DownloadService>(DownloadService(), permanent: true);
    }
  }
}
