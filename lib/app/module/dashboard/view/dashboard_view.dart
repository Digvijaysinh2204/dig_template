import '../../../utils/import.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
                () => CustomTextView(
              text: context.loc.welcomeUser(controller.userName.value),
              style: AppTextStyle.bold(
                size: 24,
                color: AppColor.text(context),
              ),
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
        ],
      ).paddingSymmetric(horizontal: 24),
    );
  }
}
