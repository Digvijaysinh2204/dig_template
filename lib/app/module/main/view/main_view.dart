import '../../../utils/import.dart';
import '../controller/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isAppBar: false,
      body: Obx(() => controller.pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.surface(context),
              border: Border(
                top: BorderSide(
                  color: AppColor.text(context).withValues(alpha: 0.05),
                  width: 1,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: (index) {
                final clickName = index == 0
                    ? AppClick.dashboardTab
                    : AppClick.moreTab;
                AnalyticsService.instance.logClick(
                  widgetName: 'MainView',
                  clickName: clickName,
                );
                controller.onTabChanged(index);
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColor.surface(context),
              selectedItemColor: AppColor.kPrimary,
              unselectedItemColor: AppColor.text(
                context,
              ).withValues(alpha: 0.4),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.grid_view_rounded),
                  activeIcon: const Icon(Icons.grid_view_rounded),
                  label: context.loc.dashboard,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.menu_rounded),
                  activeIcon: const Icon(Icons.menu_rounded),
                  label: context.loc.more,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
