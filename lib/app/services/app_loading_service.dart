import '../utils/import.dart';
class AppLoadingService extends GetxService {
  static AppLoadingService get instance => Get.find<AppLoadingService>();
  final _activeCalls = 0.obs;
  bool get isLoading => _activeCalls.value > 0;
  void startLoading() {
    _activeCalls.value++;
  }
  void stopLoading() {
    if (_activeCalls.value > 0) {
      _activeCalls.value--;
    }
  }
}
