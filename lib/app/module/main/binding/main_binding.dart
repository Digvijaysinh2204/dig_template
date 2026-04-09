import 'package:get/get.dart';
import '../controller/main_controller.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../more/controller/more_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<MoreController>(() => MoreController());
  }
}
