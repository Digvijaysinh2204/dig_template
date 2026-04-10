import '../../../utils/import.dart';

class OtpController extends GetxController {
  final String phoneNumber = Get.arguments ?? '';
  final tfOtpController = TextEditingController();
  final focusNode = FocusNode();

  RxBool isLoading = false.obs;

  void verifyOtp(String code) {
    if (code == AppConstant.staticOtp) {
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 1), () {
        isLoading.value = false;

        final List<dynamic> userListJson =
            StoreData.readData(StoreKey.userList) ?? [];
        final userList = UserModel.fromJsonList(userListJson);

        final existingUser = userList.firstWhereOrNull(
          (u) => u.mobile == phoneNumber,
        );

        if (existingUser != null) {
          UserService.instance.updateUser(existingUser);
          StoreData.setData(StoreKey.isLogin, true);
          showToast(
            message: Get.context!.loc.otpVerifiedSuccess,
            type: ToastType.success,
          );
          Get.offAllNamed(AppRoute.main);
        } else {
          showToast(
            message: Get.context!.loc.otpVerifiedSuccess,
            type: ToastType.success,
          );
          Get.offAllNamed(AppRoute.registerView, arguments: phoneNumber);
        }
      });
    } else {
      showToast(message: Get.context!.loc.invalidOtp, type: ToastType.error);
      tfOtpController.clear();
    }
  }

  void resendOtp() {
    showToast(
      message: Get.context!.loc.otpResentSuccess,
      type: ToastType.success,
    );
  }

  @override
  void onClose() {
    tfOtpController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
