import '../utils/import.dart';
class ThemeService extends GetxService {
  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;
  ThemeMode get themeMode => _themeMode.value;
  @override
  void onInit() {
    final isDark = Get.find<StorageService>().readData<bool>(StoreKey.isDarkMode);
    if (isDark != null) {
      _themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    } else {
      _themeMode.value = ThemeMode.system;
    }
    super.onInit();
  }
  void changeThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    final storage = Get.find<StorageService>();
    if (mode == ThemeMode.system) {
      storage.removeData(StoreKey.isDarkMode);
    } else {
      storage.setData(StoreKey.isDarkMode, mode == ThemeMode.dark);
    }
    Get.changeThemeMode(mode);
  }
}
