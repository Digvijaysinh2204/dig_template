import '../../../utils/import.dart';

class DashboardController extends GetxController {
  final RxString userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final user = UserService.instance.currentUser;
    userName.value = user?.name ?? 'User';
  }
}
