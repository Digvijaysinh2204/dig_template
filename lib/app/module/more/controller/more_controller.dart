import '../../../utils/import.dart';

class MoreController extends GetxController {
  void onLogout() {
    final loc = Get.context!.loc;
    showAppAdaptiveDialog(
      context: Get.context!,
      title: loc.logout,
      message: loc.logoutConfirmation,
      primaryActionLabel: loc.logout,
      isDestructive: true,
      onPrimaryAction: () {
        UserService.instance.logout();
      },
    );
  }

  void onDeleteAccount() {
    final loc = Get.context!.loc;
    showAppAdaptiveDialog(
      context: Get.context!,
      title: loc.deleteAccount,
      message: loc.deleteAccountConfirmation,
      primaryActionLabel: loc.deleteAccount,
      isDestructive: true,
      onPrimaryAction: () {
        final currentUser = UserService.instance.currentUser;
        if (currentUser != null) {
          final List<dynamic> userListJson = StoreData.readData(StoreKey.userList) ?? [];
          userListJson.removeWhere((item) => UserModel.fromJson(item).mobile == currentUser.mobile);
          StoreData.setData(StoreKey.userList, userListJson);
        }
        UserService.instance.logout();
      },
    );
  }

  void onChangeTheme() {
    final loc = Get.context!.loc;
    showAdaptiveActionSheet(
      context: Get.context!,
      title: loc.theme,
      actions: [
        AdaptiveAction(
          label: loc.light,
          clickName: AppClick.changeTheme,
          onPressed: () => ThemeService.instance.changeThemeMode(ThemeMode.light),
        ),
        AdaptiveAction(
          label: loc.dark,
          clickName: AppClick.changeTheme,
          onPressed: () => ThemeService.instance.changeThemeMode(ThemeMode.dark),
        ),
        AdaptiveAction(
          label: loc.system,
          clickName: AppClick.changeTheme,
          onPressed: () => ThemeService.instance.changeThemeMode(ThemeMode.system),
        ),
      ],
    );
  }

  void onChangeLanguage() {
    final loc = Get.context!.loc;
    showAdaptiveActionSheet(
      context: Get.context!,
      title: loc.selectLanguage,
      actions: [
        AdaptiveAction(
          label: loc.english,
          clickName: AppClick.changeLanguage,
          onPressed: () => LanguageService.instance.changeLocale('en'),
        ),
        AdaptiveAction(
          label: loc.hindi,
          clickName: AppClick.changeLanguage,
          onPressed: () => LanguageService.instance.changeLocale('hi'),
        ),
        AdaptiveAction(
          label: loc.gujarati,
          clickName: AppClick.changeLanguage,
          onPressed: () => LanguageService.instance.changeLocale('gu'),
        ),
      ],
    );
  }
}
