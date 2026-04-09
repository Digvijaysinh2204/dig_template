import '../utils/import.dart';
class ThemeService extends GetxService {
  static ThemeService get instance => Get.find<ThemeService>();
  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;
  ThemeMode get themeMode => _themeMode.value;
  @override
  void onInit() {
    final isDark = StoreData.readData<bool>(StoreKey.isDarkMode);
    if (isDark != null) {
      _themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    } else {
      _themeMode.value = ThemeMode.system;
    }
    super.onInit();
  }
  void changeThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    if (mode == ThemeMode.system) {
      StoreData.removeData(StoreKey.isDarkMode);
    } else {
      StoreData.setData(StoreKey.isDarkMode, mode == ThemeMode.dark);
    }
    Get.changeThemeMode(mode);
  }
}
