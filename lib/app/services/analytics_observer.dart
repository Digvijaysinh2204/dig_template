import '../utils/import.dart';
class AppAnalyticsObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _sendScreenView(route);
  }
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _sendScreenView(newRoute);
  }
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _sendScreenView(previousRoute);
  }
  void _sendScreenView(Route<dynamic>? route) {
    if (AppConstant.isFirebaseEnabled &&
        route != null &&
        route.settings.name != null) {
      final String screenName = route.settings.name!;
      Get.find<AnalyticsService>().logScreenView(screenName);
    }
  }
}
