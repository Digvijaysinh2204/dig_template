import 'dart:io';
import '../utils/import.dart';
class AnalyticsService extends GetxService {
  FirebaseAnalytics? get _analytics =>
      AppConstant.isFirebaseEnabled ? FirebaseAnalytics.instance : null;
  Future<void> setUserIdentifier(UserModel user) async {
    if (!AppConstant.isFirebaseEnabled) return;
    try {
      final userJson = user.toJson();
      final deviceInfo = Get.find<DeviceInfoService>();
      final Map<String, dynamic> fullData = {
        'user': userJson,
        'device': deviceInfo.deviceData,
        'app': {
          'version': deviceInfo.packageInfo?.version,
          'buildNumber': deviceInfo.packageInfo?.buildNumber,
          'packageName': deviceInfo.packageInfo?.packageName,
        },
        'platform': Platform.operatingSystem,
        'last_update': DateTime.now().toIso8601String(),
      };
      await _analytics?.setUserId(id: user.id?.toString());
      for (var entry in userJson.entries) {
        if (entry.value != null) {
          await _analytics?.setUserProperty(
            name: 'u_${entry.key}',
            value: entry.value.toString(),
          );
        }
      }
      await _analytics?.setUserProperty(
        name: 'device_id',
        value: deviceInfo.deviceId,
      );
      await _analytics?.setUserProperty(
        name: 'app_version',
        value: deviceInfo.packageInfo?.version,
      );
      await logEvent(
        AnalyticsKeys.userIdentify,
        parameters: {AnalyticsKeys.userData: jsonEncode(fullData)},
      );
    } catch (e) {
      kLog(content: e, title: 'ANALYTICS_ERROR');
    }
  }
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    if (!AppConstant.isFirebaseEnabled) return;
    try {
      final Map<String, Object> params = {
        AnalyticsKeys.timestamp: DateTime.now().toIso8601String(),
        if (parameters != null)
          ...parameters.map((key, value) => MapEntry(key, value.toString())),
      };
      await _analytics?.logEvent(name: name, parameters: params);
      kLog(content: 'Event: $name | Params: $params', title: 'ANALYTICS');
    } catch (e) {
      kLog(content: e, title: 'ANALYTICS_ERROR');
    }
  }
  Future<void> logScreenView(String screenName, {String? screenClass}) async {
    if (!AppConstant.isFirebaseEnabled) return;
    try {
      await _analytics?.logScreenView(
        screenName: screenName,
        screenClass: screenClass ?? screenName,
      );
      await logEvent(
        AnalyticsKeys.screenView,
        parameters: {
          AnalyticsKeys.screenName: screenName,
          AnalyticsKeys.screenClass: screenClass ?? screenName,
        },
      );
    } catch (e) {
      kLog(content: e, title: 'ANALYTICS_ERROR');
    }
  }
  Future<void> logClick({
    required String widgetName,
    required String clickName,
    Map<String, dynamic>? extra,
  }) async {
    await logEvent(
      AnalyticsKeys.widgetClick,
      parameters: {
        AnalyticsKeys.widgetName: widgetName,
        AnalyticsKeys.clickName: clickName,
        if (extra != null) ...extra,
      },
    );
  }
  Future<void> clearUserData() async {
    if (!AppConstant.isFirebaseEnabled) return;
    try {
      await _analytics?.setUserId(id: null);
      await logEvent(AnalyticsKeys.userLogout);
    } catch (e) {
      kLog(content: e, title: 'ANALYTICS_ERROR');
    }
  }
}
