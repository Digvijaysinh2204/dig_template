import '../../../utils/import.dart';
import '../../dashboard/view/dashboard_view.dart';
import '../../more/view/more_view.dart';

class MainController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final List<Widget> pages = [const DashboardView(), const MoreView()];

  void onTabChanged(int index) {
    selectedIndex.value = index;
    kLog(title: 'TAB_CHANGED', content: 'Index: $index');
  }
}
