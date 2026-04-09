import '../../../utils/import.dart';
import '../controller/main_controller.dart';
import '../../dashboard/view/dashboard_view.dart';
import '../../more/view/more_view.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: const [DashboardView(), MoreView()],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: AppColor.scaffold(context),
          border: Border(
            top: BorderSide(color: AppColor.divider(context), width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTabIndex,
          backgroundColor: AppColor.scaffold(context),
          selectedItemColor: AppColor.kPrimary,
          unselectedItemColor: AppColor.text(context).withValues(alpha: 0.4),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_outlined),
              activeIcon: Icon(Icons.more_horiz_rounded),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
