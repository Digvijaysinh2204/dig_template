import '../../../utils/import.dart';

class MainController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
    kLog(title: 'TAB_CHANGED', content: 'Index: $index');
  }
}
