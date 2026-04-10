import 'package:flutter_timezone/flutter_timezone.dart';
import '../utils/import.dart';

class TimezoneService extends GetxService {
  @override
  void onInit() {
    _fetchTimezone();
    super.onInit();
  }
  final _timezone = 'UTC'.obs;
  String get timezone => _timezone.value;
  Future<TimezoneService> init() async {
    await _fetchTimezone();
    return this;
  }

  Future<void> _fetchTimezone() async {
    try {
      final currentTimezone = await FlutterTimezone.getLocalTimezone();
      _timezone.value = currentTimezone.toString();
      kLog(title: 'TIMEZONE', content: _timezone.value);
    } catch (e) {
      kLog(title: 'TIMEZONE_ERROR', content: e);
      _timezone.value = 'UTC';
    }
  }
}
