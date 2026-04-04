import 'dart:developer' as dev;
import 'import.dart';
void kLog({required dynamic content, String title = ''}) {
  if (kReleaseMode || AppConfig.currentEnvironment == Environment.live) return;
  final String name = title.isEmpty ? 'DEBUG' : title.toUpperCase();
  try {
    String message;
    if (content is Map || content is List) {
      try {
        message = const JsonEncoder.withIndent('  ').convert(content);
      } catch (_) {
        message = content.toString();
      }
    } else {
      message = content.toString();
    }
    dev.log(message, name: name);
  } catch (e) {
    dev.log(content.toString(), name: name);
  }
}
