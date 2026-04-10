import '../../../utils/import.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void onInit() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    super.onInit();
  }

  @override
  void onReady() {
    _startInitialization();
    super.onReady();
  }

  Future<void> _startInitialization() async {
    try {
      await Get.find<StorageService>().init();
      await Get.find<LocalNotificationService>().init();

      if (AppConstant.isFirebaseEnabled) {
        await Firebase.initializeApp();
        await Get.find<FcmService>().init();
      }

      await Future.delayed(const Duration(milliseconds: 1500));
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
