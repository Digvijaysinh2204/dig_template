import '../utils/import.dart';
class CrashlyticsService extends GetxService {
  Future<CrashlyticsService> init() async {
    if (!AppConstant.isFirebaseEnabled) return this;
    try {
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      kLog(content: 'Crashlytics initialized', title: 'CRASHLYTICS');
    } catch (e) {
      kLog(
        content: 'Failed to init Crashlytics: $e',
        title: 'CRASHLYTICS ERROR',
      );
    }
    return this;
  }
  Future<void> log(String message) async {
    if (!AppConstant.isFirebaseEnabled) return;
    try {
      await FirebaseCrashlytics.instance.log(message);
    } catch (e) {
      kLog(content: 'Failed to log: $e', title: 'CRASHLYTICS ERROR');
    }
  }
  Future<void> recordError(
    dynamic error,
    StackTrace? stack, {
    bool fatal = false,
  }) async {
    if (!AppConstant.isFirebaseEnabled) return;
    try {
      await FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: fatal,
      );
    } catch (e) {
      kLog(content: 'Failed to record error: $e', title: 'CRASHLYTICS ERROR');
    }
  }
  Future<void> setCustomKey(String key, dynamic value) async {
    if (!AppConstant.isFirebaseEnabled) return;
    try {
      await FirebaseCrashlytics.instance.setCustomKey(key, value);
    } catch (e) {
      kLog(content: 'Failed to set custom key: $e', title: 'CRASHLYTICS ERROR');
    }
  }
  Future<void> setUserIdentifier(String identifier) async {
    if (!AppConstant.isFirebaseEnabled) return;
    try {
      await FirebaseCrashlytics.instance.setUserIdentifier(identifier);
    } catch (e) {
      kLog(
        content: 'Failed to set user identifier: $e',
        title: 'CRASHLYTICS ERROR',
      );
    }
  }
}
