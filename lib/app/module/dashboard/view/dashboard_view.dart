import '../../../utils/import.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => CustomTextView(
              text: context.loc.welcomeUser(controller.userName.value),
              style: AppTextStyle.bold(size: 24, color: AppColor.text(context)),
            ),
          ),
          const Gap(10),
          CustomTextView(
            text: context.loc.successfullyLoggedIn,
            style: AppTextStyle.regular(
              size: 16,
              color: AppColor.text(context).withValues(alpha: 0.6),
            ),
          ),
          const Gap(40),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _buildTestButton('User 1', '1'),
              _buildTestButton('User 2', '2'),
              _buildTestButton('User 3', '3'),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 24),
    );
  }

  Widget _buildTestButton(String label, String id) {
    return ElevatedButton(
      onPressed: () {
        LocalNotificationService.instance.show(
          title: 'User Detail',
          body: 'Tap to view User $id',
          payload: {'type': 'user_detail', 'id': id, 'name': 'User $id'},
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.kPrimary.withValues(alpha: 0.1),
        foregroundColor: AppColor.kPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label),
    );
  }
}
