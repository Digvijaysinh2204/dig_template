import '../utils/import.dart';
class StorageService extends GetxService {
  static StorageService get instance => Get.find<StorageService>();
  final GetStorage _box = GetStorage();
  Future<StorageService> init() async {
    await GetStorage.init();
    kLog(content: 'GetStorage initialized', title: 'INIT');
    return this;
  }
  Future<void> setData(String key, dynamic value) async {
    try {
      final encoded = _encodeValue(value);
      final encryptedMap = Get.find<CryptoService>().encryptGCM(encoded);
      await _box.write(key, encryptedMap);
      kLog(
        title: 'STORE_DATA: ${_formatKey(key)}',
        content: {'key': key, 'value': value, 'encrypted': encryptedMap},
      );
    } catch (e) {
      kLog(title: 'STORE_DATA_ERROR', content: e);
    }
  }
  T? readData<T>(String key) {
    try {
      final rawValue = _box.read(key);
      if (rawValue == null) return null;
      if (rawValue is Map &&
          rawValue.containsKey('iv') &&
          rawValue.containsKey('encrypted')) {
        final decrypted = Get.find<CryptoService>().decryptGCM(
          encryptedText: rawValue['encrypted'],
          ivBase64: rawValue['iv'],
        );
        final decoded = _decodeValue(decrypted);
        return _castTo<T>(decoded);
      }
      return _castTo<T>(rawValue);
    } catch (e) {
      kLog(title: 'READ_DATA_ERROR', content: e);
      return null;
    }
  }
  void listen<T>(String key, void Function(T? value) callback) {
    _box.listenKey(key, (rawValue) {
      if (rawValue == null) {
        callback(null);
        return;
      }
      callback(readData<T>(key));
    });
  }
  Future<void> removeData(String key) async {
    await _box.remove(key);
    kLog(content: 'Removed: ${_formatKey(key)}', title: 'REMOVE');
  }
  Future<void> clear() async {
    await _box.erase();
    kLog(content: 'Storage cleared', title: 'CLEAN');
  }
  String _formatKey(String key) {
    return key.replaceAll(RegExp(r'(?=[A-Z])'), '_').toLowerCase();
  }
  String _encodeValue(dynamic value) {
    if (value is String || value is num || value is bool) {
      return value.toString();
    }
    return jsonEncode(value);
  }
  dynamic _decodeValue(String decrypted) {
    try {
      return jsonDecode(decrypted);
    } catch (_) {
      if (decrypted == 'true') return true;
      if (decrypted == 'false') return false;
      return num.tryParse(decrypted) ?? decrypted;
    }
  }
  T? _castTo<T>(dynamic value) {
    if (value is T) return value;
    return null;
  }
}

class StoreData {
  static StorageService get _service => Get.find<StorageService>();

  static Future<void> setData(String key, dynamic value) =>
      _service.setData(key, value);

  static T? readData<T>(String key) => _service.readData<T>(key);

  static Future<void> removeData(String key) => _service.removeData(key);

  static Future<void> clear() => _service.clear();

  static void listen<T>(String key, void Function(T? value) callback) =>
      _service.listen<T>(key, callback);
}
