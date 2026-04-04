import 'dart:io';
import 'package:background_downloader/background_downloader.dart';
import '../utils/import.dart';
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (AppConstant.isFirebaseEnabled) {
    await Firebase.initializeApp();
  }
  kLog(content: message.toMap(), title: 'BACKGROUND NOTIFICATION');
}
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  kLog(
    content: 'Background notification tapped: ${notificationResponse.payload}',
    title: 'BACKGROUND_NOTIFICATION_TAP',
  );
}
class NotificationService extends GetxService {
  FirebaseMessaging? get messaging =>
      AppConstant.isFirebaseEnabled ? FirebaseMessaging.instance : null;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const String _channelId = 'default_notification_channel_id';
  static const String _channelName = 'Default Notification Channel';
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    _channelId,
    _channelName,
    description: _channelName,
    importance: Importance.max,
    playSound: true,
    showBadge: true,
  );
  Future<NotificationService> init() async {
    await _initializeFlutterLocalNotifications();
    if (AppConstant.isFirebaseEnabled) {
      await _setupIOS();
      await _requestNotificationPermission();
      _initializeFirebaseListeners();
      await _handleLaunchNotification();
    }
    return this;
  }
  void _initializeFirebaseListeners() {
    if (!AppConstant.isFirebaseEnabled) return;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        kLog(content: message.toMap(), title: 'FOREGROUND_NOTIFICATION');
        await _showNotification(message: message);
      } catch (e) {
        kLog(content: e, title: 'FOREGROUND_NOTIFICATION_ERROR');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      kLog(content: 'App opened from background', title: 'NOTIFICATION_STATE');
      _handleMessageFromData(message.data);
    });
  }
  Future<void> _initializeFlutterLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@drawable/notification');
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
    await _flutterLocalNotificationsPlugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          final Map<String, dynamic> payload = jsonDecode(response.payload!);
          _handleMessageFromData(payload);
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }
  Future<void> _showNotification({required RemoteMessage message}) async {
    if (message.notification == null) return;
    if (Platform.isIOS && message.notification?.apple != null) return;
    final androidDetails = AndroidNotificationDetails(
      _channel.id, _channel.name,
      channelDescription: _channel.description,
      importance: _channel.importance,
      priority: Priority.high,
      playSound: _channel.playSound,
      icon: '@drawable/notification',
      color: AppColor.kPrimary,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true, presentBadge: true, presentSound: true);
    final notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
    await _flutterLocalNotificationsPlugin.show(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: notificationDetails,
      payload: jsonEncode(message.data),
    );
  }
  void _handleMessageFromData(Map<String, dynamic> data) {
    if (data['type'] == 'Download') {
      FileDownloader().openFile(filePath: data['path']);
    } else {}
  }
  Future<void> _handleLaunchNotification() async {
    final launchDetails = await _flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      final payload = launchDetails!.notificationResponse?.payload;
      if (payload != null) {
        _handleMessageFromData(jsonDecode(payload));
      }
    }
    if (AppConstant.isFirebaseEnabled) {
      final initialMessage = await messaging?.getInitialMessage();
      if (initialMessage != null) {
        _handleMessageFromData(initialMessage.data);
      }
    }
  }
  Future<void> _setupIOS() async {
    if (Platform.isIOS && AppConstant.isFirebaseEnabled) {
      await messaging?.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    }
  }
  Future<void> _requestNotificationPermission() async {
    if (!AppConstant.isFirebaseEnabled) return;
    await messaging?.requestPermission(
      alert: true, announcement: true, badge: true, sound: true);
    await getFirebaseToken();
  }
  Future<void> getFirebaseToken() async {
    if (!AppConstant.isFirebaseEnabled) return;
    try {
      if (Platform.isIOS) await messaging?.getAPNSToken();
      final token = await messaging?.getToken() ?? 'N/A';
      Get.find<StorageService>().setData(StoreKey.firebaseToken, token);
    } catch (_) {
      Get.find<StorageService>().setData(StoreKey.firebaseToken, 'N/A');
    }
  }
  Future<void> showCustomNotification({
    required String title, required String body, required Map<String, dynamic> payload,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      _channel.id, _channel.name,
      channelDescription: _channel.description,
      importance: _channel.importance,
      priority: Priority.high,
      playSound: _channel.playSound,
      icon: '@drawable/notification',
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true, presentBadge: true, presentSound: true);
    final details = NotificationDetails(android: androidDetails, iOS: iosDetails);
    await _flutterLocalNotificationsPlugin.show(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title: title, body: body,
      notificationDetails: details,
      payload: jsonEncode(payload),
    );
  }
}
