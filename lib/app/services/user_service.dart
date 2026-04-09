import '../utils/import.dart';

class UserService extends GetxService {
  static UserService get instance => Get.find<UserService>();

  final Rxn<UserModel> _user = Rxn<UserModel>();
  UserModel? get currentUser => _user.value;
  bool get isLoggedIn => _user.value != null;

  @override
  void onInit() {
    super.onInit();
    _loadUser();
  }

  void _loadUser() {
    final userData = StoreData.readData<Map<String, dynamic>>(StoreKey.userData);
    if (userData != null) {
      _user.value = UserModel.fromJson(userData);
    }
  }

  void updateUser(UserModel? user) {
    _user.value = user;
    if (user != null) {
      StoreData.setData(StoreKey.userData, user.toJson());
      StoreData.setData(StoreKey.isLogin, true);
    } else {
      StoreData.removeData(StoreKey.userData);
      StoreData.setData(StoreKey.isLogin, false);
    }
  }

  Future<void> logout() async {
    _user.value = null;
    await StoreData.removeData(StoreKey.userData);
    await StoreData.setData(StoreKey.isLogin, false);
    await StoreData.removeData(StoreKey.accessToken);
    
    // Clear Analytics
    await Get.find<AnalyticsService>().clearUserData();
    
    Get.offAllNamed(AppRoute.auth);
  }
}
