import 'package:dlibphonenumber/dlibphonenumber.dart';
import '../../../utils/import.dart';
class AuthController extends GetxController {
  final tfPhoneController = TextEditingController();
  final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
  final RxBool isLoading = false.obs;
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return Get.context?.loc.phoneNumber;
    }
    try {
      final number = phoneUtil.parse(value, 'IN');
      if (!phoneUtil.isValidNumber(number)) {
        return Get.context?.loc.badResponseFormat('Invalid Number');
      }
    } catch (e) {
      return Get.context?.loc.badResponseFormat('Invalid Number');
    }
    return null;
  }
  void onLogin() {
    final validationError = validatePhoneNumber(tfPhoneController.text);
    if (validationError == null) {
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false;
        Get.find<StorageService>().setData(StoreKey.isLogin, true);
        Get.offAllNamed(AppRoute.main);
      });
    } else {
      Get.find<ToastService>().show(message: validationError, type: ToastType.error);
    }
  }
  @override
  void onClose() {
    tfPhoneController.dispose();
    super.onClose();
  }
}
