import '../utils/import.dart';


class LocalNotificationService extends GetxService {
  static LocalNotificationService get instance => Get.find<LocalNotificationService>();

  final _local = FlutterLocalNotificationsPlugin();

  Future<LocalNotificationService> init() async {
    kLog(content: 'Initializing Local Notification Service...', title: 'LOCAL_NOTIF');
    
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _local.initialize(
      settings: const InitializationSettings(android: androidSettings, iOS: iosSettings),
      onDidReceiveNotificationResponse: (res) {
        if (res.payload != null) {
          NotificationRouter.handle(
            NotificationPayload(jsonDecode(res.payload!)),
          );
        }
      },
    );

    await _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            'default_channel',
            'Notifications',
            importance: Importance.max,
            playSound: true,
          ),
        );

    await _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    return this;
  }

  Future<void> checkInitialNavigation() async {
    final details = await _local.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp && details.notificationResponse?.payload != null) {
      NotificationRouter.handle(
        NotificationPayload(jsonDecode(details.notificationResponse!.payload!)),
      );
    }
  }

  Future<void> show({
    required String title,
    required String body,
    required Map<String, dynamic> payload,
  }) async {
    kLog(content: 'Showing Local Notification: $title', title: 'LOCAL_NOTIF');
    const android = AndroidNotificationDetails(
      'default_channel',
      'Notifications',
      importance: Importance.max,
      priority: Priority.max,
      icon: '@mipmap/ic_launcher',
    );
    await _local.show(
      id: DateTime.now().millisecondsSinceEpoch % 100000,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: android,
        iOS: DarwinNotificationDetails(),
      ),
      payload: jsonEncode(payload),
    );
  }
}
