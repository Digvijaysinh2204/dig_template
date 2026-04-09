import 'package:dlibphonenumber/dlibphonenumber.dart';
import '../../../utils/import.dart';
class AuthController extends GetxController {
  final tfPhoneController = TextEditingController();
  final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
  final RxBool isLoading = false.obs;
  String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return Get.context?.loc.enterValidPhone;
    }
    try {
      final number = phoneUtil.parse(value, 'IN');
      if (!phoneUtil.isValidNumber(number)) {
        return Get.context?.loc.invalidPhoneNumber;
      }
    } catch (e) {
      return Get.context?.loc.invalidPhoneNumber;
    }
    return null;
  }

  void onLogin() {
    final error = validatePhoneNumber(tfPhoneController.text);
    if (error != null) {
      showToast(message: error, type: ToastType.error);
      return;
    }

    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      Get.toNamed(AppRoute.otp, arguments: tfPhoneController.text);
    });
  }
  @override
  void onClose() {
    tfPhoneController.dispose();
    super.onClose();
  }
}
