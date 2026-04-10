import 'package:background_downloader/background_downloader.dart';

import '../utils/import.dart';

class NotificationPayload {
  final String? id;
  final String? route;
  final String? type;
  final Map<String, dynamic> data;

  NotificationPayload(this.data)
    : id =
          data['id']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      route = data['route'],
      type = data['type'];
}

class NotificationRouter {
  static String? _lastId;

  static void handle(NotificationPayload payload) {
    kLog(content: 'Handling Notification: ${payload.id}', title: 'ROUTER');
    if (_lastId == payload.id) return;
    _lastId = payload.id;
    Future.delayed(const Duration(seconds: 2), () => _lastId = null);

    if (payload.route != null) {
      _navigate(payload.route!, payload.data);
      return;
    }

    switch (payload.type) {
      case 'user_detail':
        Get.toNamed(
          AppRoute.testDetail.replaceFirst(':id', payload.id ?? '0'),
          arguments: payload.data,
          preventDuplicates: false,
        );
        break;
      case 'order_update':
        _navigate(AppRoute.main, payload.data);
        break;
      case 'Download':
        if (payload.data['path'] != null) {
          FileDownloader().openFile(filePath: payload.data['path']);
        }
        break;
      default:
        kLog(content: 'Type: ${payload.type}', title: 'ROUTER_UNHANDLED');
    }
  }

  static void _navigate(String routeName, Map<String, dynamic> data) {
    kLog(content: 'Navigating to: $routeName', title: 'ROUTER');
    final isSameRoute = Get.currentRoute == routeName;
    final isSameArgs = Get.arguments?.toString() == data.toString();

    if (!isSameRoute || !isSameArgs) {
      Get.toNamed(routeName, arguments: data, preventDuplicates: false);
    }
  }
}
