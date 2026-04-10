import '../utils/import.dart';

class UserService extends GetxService {
  static UserService get instance => Get.find<UserService>();

  final Rxn<UserModel> _user = Rxn<UserModel>();
  UserModel? get currentUser => _user.value;
  bool get isLoggedIn => _user.value != null;

  // Guest logic: id 0 or null or <= 0
  bool get isGuest => currentUser?.id == null || (currentUser?.id ?? 0) <= 0;

  @override
  void onInit() {
    super.onInit();
    _loadUser();
    if (!isGuest) {
      refreshUserProfile();
    }
  }

  void _loadUser() {
    final userData = StoreData.readData<Map<String, dynamic>>(
      StoreKey.userData,
    );
    if (userData != null) {
      _user.value = UserModel.fromJson(userData);
    }
  }

  Future<void> refreshUserProfile() async {
    final response = await ApiService.request<StatusModel<UserModel>>(
      method: RequestMethod.get,
      url: Endpoints.profile,
      fromJson: (json) => StatusModel<UserModel>.fromJson(
        json,
        (data) => UserModel.fromJson(data),
      ),
    );
    if (response.isSuccess && response.data != null) {
      updateUser(response.data?.data);
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
    final loader = Get.find<AppLoadingService>();
    loader.startLoading();
    _user.value = null;
    await StoreData.removeData(StoreKey.userData);
    await StoreData.setData(StoreKey.isLogin, false);
    await StoreData.removeData(StoreKey.accessToken);

    if (AppConstant.isFirebaseEnabled) {
      final fcmService = Get.find<FcmService>();
      await fcmService.messaging?.deleteToken();
      fcmService.getFirebaseToken();
    }

    // Clear Analytics
    await Get.find<AnalyticsService>().clearUserData();

    loader.stopLoading();
    Get.offAllNamed(AppRoute.auth);
  }
}
