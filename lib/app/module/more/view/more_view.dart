import '../../../utils/import.dart';
import '../controller/more_controller.dart';

class MoreView extends GetView<MoreController> {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isAppBar: true,
      title: CustomTextView(text: context.loc.more),
      showBackButton: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context),
            const Gap(40),
            _buildSectionHeader(context.loc.settings.toUpperCase()),
            _buildMenuItem(
              context,
              icon: Icons.dark_mode_outlined,
              title: context.loc.theme,
              clickName: AppClick.changeTheme,
              onTap: controller.onChangeTheme,
            ),
            _buildMenuItem(
              context,
              icon: Icons.language_rounded,
              title: context.loc.language,
              clickName: AppClick.changeLanguage,
              onTap: controller.onChangeLanguage,
            ),
            const Gap(32),
            _buildSectionHeader(context.loc.more.toUpperCase()),
            _buildMenuItem(
              context,
              icon: Icons.privacy_tip_outlined,
              title: context.loc.privacyPolicy,
              clickName: AppClick.privacyPolicy,
              onTap: () {},
            ),
            _buildMenuItem(
              context,
              icon: Icons.description_outlined,
              title: context.loc.termsOfService,
              clickName: AppClick.termsOfService,
              onTap: () {},
            ),
            const Gap(32),
            _buildSectionHeader(
              context.loc.logout.toUpperCase(),
              isDanger: true,
            ),
            _buildMenuItem(
              context,
              icon: Icons.logout_rounded,
              title: context.loc.logout,
              clickName: AppClick.logout,
              titleColor: AppColor.kError,
              iconColor: AppColor.kError,
              onTap: controller.onLogout,
            ),
            _buildMenuItem(
              context,
              icon: Icons.delete_forever_rounded,
              title: context.loc.deleteAccount,
              clickName: AppClick.deleteAccount,
              titleColor: AppColor.kError,
              iconColor: AppColor.kError,
              onTap: controller.onDeleteAccount,
            ),
            const Gap(40),
            Center(
              child: CustomTextView(
                text: 'v${Get.find<DeviceInfoService>().appVersion ?? '1.0.0'}',
                style: AppTextStyle.regular(
                  size: 12,
                  color: AppColor.text(context).withValues(alpha: 0.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.surface(context),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColor.text(context).withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColor.kPrimary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 32,
              color: AppColor.kPrimary,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextView(
                  text: UserService.instance.currentUser?.name ?? 'User',
                  style: AppTextStyle.bold(
                    size: 18,
                    color: AppColor.text(context),
                  ),
                ),
                const Gap(2),
                CustomTextView(
                  text: UserService.instance.currentUser?.email ?? '',
                  style: AppTextStyle.regular(
                    size: 14,
                    color: AppColor.text(context).withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool isDanger = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: CustomTextView(
        text: title,
        style: AppTextStyle.bold(
          size: 12,
          color: isDanger
              ? AppColor.kError.withValues(alpha: 0.7)
              : AppColor.kPrimary.withValues(alpha: 0.6),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String clickName,
    required VoidCallback onTap,
    Color? titleColor,
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CustomInkWell(
        clickName: clickName,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: AppColor.surface(context),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColor.text(context).withValues(alpha: 0.05),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color:
                    iconColor ?? AppColor.text(context).withValues(alpha: 0.7),
                size: 22,
              ),
              const Gap(16),
              Expanded(
                child: CustomTextView(
                  text: title,
                  style: AppTextStyle.medium(
                    size: 16,
                    color: titleColor ?? AppColor.text(context),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.text(context).withValues(alpha: 0.2),
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
