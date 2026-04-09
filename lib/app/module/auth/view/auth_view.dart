import '../../../utils/import.dart';
import '../controller/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isAppBar: false,
      isSafeAreaTop: true,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const Gap(60),
            _buildTopIcon(context),
            const Gap(40),
            _buildTextHeader(context),
            const Gap(50),
            _buildPhoneInput(context),
            const Gap(32),
            _buildContinueButton(context),
            const Gap(60),
            _buildFooter(context),
          ],
        ).paddingSymmetric(horizontal: 24),
      ),
    );
  }

  Widget _buildTopIcon(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        color: AppColor.kPrimary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColor.kPrimary.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(
        Icons.trending_up_rounded,
        color: AppColor.kWhite,
        size: 54,
      ),
    );
  }

  Widget _buildTextHeader(BuildContext context) {
    return Column(
      children: [
        CustomTextView(
          text: context.loc.welcomeTo(AppConstant.appName),
          textAlign: TextAlign.center,
          style: AppTextStyle.bold(size: 30, color: AppColor.text(context)),
        ),
        const Gap(12),
        CustomTextView(
          text: context.loc.loginSignupSubtitle,
          textAlign: TextAlign.center,
          style: AppTextStyle.regular(
            size: 16,
            color: AppColor.text(context).withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneInput(BuildContext context) {
    return CustomTextField(
      controller: controller.tfPhoneController,
      textInputType: TextInputType.phone,
      textStyle: AppTextStyle.bold(
        size: 18,
        color: AppColor.text(context),
        letterSpacing: 1.2,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        PhoneNumberFormatter('IN'),
      ],
      hintText: context.loc.phoneHint,
      hintStyle: AppTextStyle.regular(
        size: 16,
        color: AppColor.text(context).withValues(alpha: 0.3),
      ),
      fillColor: AppColor.surface(context),
      enableBorderColor: AppColor.text(context).withValues(alpha: 0.1),
      focusBorderColor: AppColor.kPrimary,
      borderRadius: 16,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 20, right: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextView(
              text: context.loc.phonePrefix,
              style: AppTextStyle.bold(
                size: 18,
                color: AppColor.text(context).withValues(alpha: 0.8),
              ),
            ),
            const Gap(12),
            Container(
              height: 24,
              width: 1,
              color: AppColor.text(context).withValues(alpha: 0.1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Obx(
      () => CustomButton(
        width: double.infinity,
        clickName: AppClick.loginContinue,
        text: context.loc.continueButton,
        isLoading: controller.isLoading.value,
        onTap: controller.onLogin,
        bgColor: AppColor.kPrimary,
        textColors: AppColor.kWhite,
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        CustomTextView(
          text: context.loc.byContinuingAgree,
          textAlign: TextAlign.center,
          style: AppTextStyle.regular(
            size: 13,
            color: AppColor.text(context).withValues(alpha: 0.5),
          ),
        ),
        const Gap(6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _footerLink(context.loc.termsOfService),
            CustomTextView(
              text: context.loc.and,
              style: AppTextStyle.regular(
                size: 13,
                color: AppColor.text(context).withValues(alpha: 0.5),
              ),
            ).paddingSymmetric(horizontal: 6),
            _footerLink(context.loc.privacyPolicy),
          ],
        ),
      ],
    );
  }

  Widget _footerLink(String text) {
    return CustomInkWell(
      clickName: AppClick.privacyPolicy,
      onTap: () {},
      child: CustomTextView(
        text: text,
        style: AppTextStyle.semiBold(
          size: 13,
          color: AppColor.kPrimary,
        ),
      ),
    );
  }
}
