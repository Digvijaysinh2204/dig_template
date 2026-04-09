import '../../../utils/import.dart';

class RegisterController extends GetxController {
  final String phoneNumber = Get.arguments ?? '';
  final tfNameController = TextEditingController();
  final tfEmailController = TextEditingController();

  RxBool isLoading = false.obs;

  void onRegister() {
    if (tfNameController.text.isEmpty) {
      showToast(
        message: Get.context!.loc.pleaseEnterName,
        type: ToastType.error,
      );
      return;
    }
    if (tfEmailController.text.isEmpty ||
        !GetUtils.isEmail(tfEmailController.text)) {
      showToast(
        message: Get.context!.loc.pleaseEnterValidEmail,
        type: ToastType.error,
      );
      return;
    }

    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;

      final newUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch,
        name: tfNameController.text.trim(),
        email: tfEmailController.text.trim(),
        mobile: phoneNumber,
        createdAt: DateTime.now().toIso8601String(),
      );

      // Save to user list
      final List<dynamic> userListJson =
          StoreData.readData(StoreKey.userList) ?? [];
      userListJson.add(newUser.toJson());
      StoreData.setData(StoreKey.userList, userListJson);

      // Update current user
      UserService.instance.updateUser(newUser);
      StoreData.setData(StoreKey.isLogin, true);

      showToast(
        message: Get.context!.loc.registrationSuccessful,
        type: ToastType.success,
      );

      Get.offAllNamed(AppRoute.mainView);
    });
  }

  @override
  void onClose() {
    tfNameController.dispose();
    tfEmailController.dispose();
    super.onClose();
  }
}
