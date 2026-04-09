import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import '../utils/import.dart';

class DeviceInfoService extends GetxService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final _deviceData = <String, dynamic>{}.obs;
  Map<String, dynamic> get deviceData => _deviceData;
  final _packageInfo = Rxn<PackageInfo>();
  PackageInfo? get packageInfo => _packageInfo.value;
  final _deviceId = RxnString();
  String? get deviceId => _deviceId.value;
  final _appVersion = RxnString();
  String? get appVersion => _appVersion.value;
  Future<DeviceInfoService> init() async {
    await _fetchDeviceInfo();
    return this;
  }

  Future<void> _fetchDeviceInfo() async {
    try {
      _packageInfo.value = await PackageInfo.fromPlatform();
      _appVersion.value =
          '${_packageInfo.value?.version}+${_packageInfo.value?.buildNumber}';
      if (Platform.isAndroid) {
        final android = await _deviceInfo.androidInfo;
        _deviceData.value = _formatAndroidInfo(android);
        _deviceId.value = android.id;
      } else if (Platform.isIOS) {
        final ios = await _deviceInfo.iosInfo;
        _deviceData.value = _formatIosInfo(ios);
        _deviceId.value = ios.identifierForVendor;
      }
      kLog(title: 'DEVICE_INFO', content: _deviceData);
      kLog(title: 'APP_VERSION', content: _appVersion.value);
    } catch (e) {
      kLog(title: 'DEVICE_INFO_ERROR', content: e);
    }
  }

  Map<String, dynamic> _formatAndroidInfo(AndroidDeviceInfo info) {
    return {
      'id': info.id,
      'model': info.model,
      'manufacturer': info.manufacturer,
      'brand': info.brand,
      'device': info.device,
      'hardware': info.hardware,
      'host': info.host,
      'display': info.display,
      'product': info.product,
      'version': info.version.release,
      'sdk': info.version.sdkInt,
      'platform': 'android',
    };
  }

  Map<String, dynamic> _formatIosInfo(IosDeviceInfo info) {
    return {
      'name': info.name,
      'systemName': info.systemName,
      'systemVersion': info.systemVersion,
      'model': info.model,
      'localizedModel': info.localizedModel,
      'identifierForVendor': info.identifierForVendor,
      'isPhysicalDevice': info.isPhysicalDevice,
      'platform': 'ios',
    };
  }
}
