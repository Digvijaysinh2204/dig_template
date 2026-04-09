import '../utils/import.dart';
class LanguageService extends GetxService {
  static LanguageService get instance => Get.find<LanguageService>();
  final _locale = const Locale(AppConstant.defaultLanguage).obs;
  Locale get locale => _locale.value;
  Future<LanguageService> init() async {
    final code =
        StoreData.readData<String>(StoreKey.languageCode) ??
        AppConstant.defaultLanguage;
    _locale.value = Locale(code);
    return this;
  }
  void changeLocale(String code) {
    _locale.value = Locale(code);
    StoreData.setData(StoreKey.languageCode, code);
    Get.updateLocale(_locale.value);
    kLog(title: 'LANGUAGE_CHANGED', content: code);
  }
}
