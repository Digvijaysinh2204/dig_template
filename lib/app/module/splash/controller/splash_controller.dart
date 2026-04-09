import '../../../utils/import.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;
  @override
  void onInit() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutCubic);
    controller.forward();
    super.onInit();
  }

  @override
  void onReady() {
    _startInitialization();
    super.onReady();
  }

  Future<void> _startInitialization() async {
    final stopwatch = Stopwatch()..start();
    try {
      await Get.find<StorageService>().init();
      await Get.find<LanguageService>().init();
      await Get.find<DeviceInfoService>().init();
      await Get.find<TimezoneService>().init();
      await Get.find<NetworkService>().init();
      if (AppConstant.isFirebaseEnabled) {
        await Firebase.initializeApp();
        await Get.find<CrashlyticsService>().init();
        await Get.find<NotificationService>().init();
        await Get.find<DownloadService>().init();
      }
      final elapsed = stopwatch.elapsedMilliseconds;
      final remaining = 2500 - elapsed;
      if (remaining > 0) {
        await Future.delayed(Duration(milliseconds: remaining));
      }
      _navigateNext();
    } catch (e) {
      kLog(content: 'Initialization Error: $e', title: 'SPLASH');
      _navigateNext();
    }
  }

  void _navigateNext() {
    final isLogin = StoreData.readData<bool>(StoreKey.isLogin) ?? false;
    if (isLogin) {
      Get.offAllNamed(AppRoute.main);
    } else {
      Get.offAllNamed(AppRoute.auth);
    }
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
