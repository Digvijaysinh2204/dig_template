import 'dart:io';
import '../utils/import.dart';


@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (AppConstant.isFirebaseEnabled) {
    await Firebase.initializeApp();
  }
}

class FcmService extends GetxService {
  static FcmService get instance => Get.find<FcmService>();

  FirebaseMessaging? get messaging =>
      AppConstant.isFirebaseEnabled ? FirebaseMessaging.instance : null;

  Future<FcmService> init() async {
    if (!AppConstant.isFirebaseEnabled) return this;
    kLog(content: 'Initializing FCM Service...', title: 'FCM');
    await messaging?.requestPermission();
    await messaging?.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((msg) => _showForeground(msg));
    FirebaseMessaging.onMessageOpenedApp.listen(
      (msg) => NotificationRouter.handle(NotificationPayload(msg.data)),
    );
    await getFirebaseToken();
    return this;
  }

  Future<void> getFirebaseToken() async {
    if (!AppConstant.isFirebaseEnabled) return;
    try {
      if (Platform.isIOS) await messaging?.getAPNSToken();
      final token = await messaging?.getToken() ?? 'N/A';
      StoreData.setData(StoreKey.firebaseToken, token);
    } catch (_) {
      StoreData.setData(StoreKey.firebaseToken, 'N/A');
    }
  }

  Future<void> checkInitialNavigation() async {
    if (!AppConstant.isFirebaseEnabled) return;
    final msg = await messaging?.getInitialMessage();
    if (msg != null) NotificationRouter.handle(NotificationPayload(msg.data));
  }

  void _showForeground(RemoteMessage msg) {
    if (msg.notification == null) return;
    LocalNotificationService.instance.show(
      title: msg.notification?.title ?? '',
      body: msg.notification?.body ?? '',
      payload: msg.data,
    );
  }
}
