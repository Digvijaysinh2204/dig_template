import '../../../utils/import.dart';
import '../../module_export.dart';

class MainController extends GetxController {
  final selectedIndex = 0.obs;

  final pages = <Widget>[const DashboardView(), const MoreView()];

  @override
  void onReady() {
    super.onReady();
    Get.find<LocalNotificationService>().checkInitialNavigation();
    if (AppConstant.isFirebaseEnabled) {
      Get.find<FcmService>().checkInitialNavigation();
    }
  }

  void onTabChanged(int index) {
    selectedIndex.value = index;
    if (index == 0) {
      Get.find<DashboardController>().onInit();
    } else if (index == 1) {
      Get.find<MoreController>().onInit();
    }
  }
}
