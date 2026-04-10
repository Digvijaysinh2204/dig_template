import '../../utils/import.dart';
import '../test_detail/test_detail_view.dart';

class TestDetailBinding extends Bindings {
  @override
  void dependencies() {
    final id = Get.parameters['id'] ?? Get.arguments?['id']?.toString() ?? '0';
    Get.lazyPut(() => TestDetailController(), tag: id);
  }
}
