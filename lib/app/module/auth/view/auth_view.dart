import '../../../utils/import.dart';
import '../controller/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isAppBar: false,
      isSafeAreaTop: false,
      isSafeAreaBottom: false,
      extendBodyBehindAppBar: true,
      statusBarDarkIcons: false,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(children: [_buildHeader(context), _buildForm(context)]),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, 40 + topPadding, 24, 60),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.kPrimary, AppColor.kSecondary],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(48),
          bottomRight: Radius.circular(48),
        ),
      ),
      child: Column(
        children: [
          CustomTextView(
            text: context.loc.welcomeTo(AppConstant.appName),
            textAlign: TextAlign.center,
            style: AppTextStyle.bold(
              size: 34,
              color: AppColor.kWhite,
              letterSpacing: 1.2,
            ),
          ),
          const Gap(12),
          CustomTextView(
            text: AppConstant.author,
            textAlign: TextAlign.center,
            style: AppTextStyle.medium(
              size: 16,
              color: AppColor.kWhite.withValues(alpha: 0.6),
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(28, 50, 28, 40 + bottomPadding),
      child: Column(
        children: [
          CustomTextView(
            text: context.loc.loginSignupSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyle.bold(size: 28, color: AppColor.text(context)),
          ),
          const Gap(12),
          CustomTextView(
            text: context.loc.mobileNumberSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyle.regular(
              size: 16,
              color: AppColor.text(context).withValues(alpha: 0.5),
            ),
          ),
          const Gap(48),
          _buildPhoneField(context),
          const Gap(40),
          Obx(
            () => CustomButton(
              width: double.infinity,
              clickName: AnalyticsKeys.loginContinue,
              text: context.loc.continueButton.toUpperCase(),
              isLoading: controller.isLoading.value,
              onTap: controller.onLogin,
              bgColor: AppColor.kPrimary,
              textColors: AppColor.kWhite,
            ),
          ),
          const Gap(48),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildPhoneField(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextView(
          text: context.loc.phoneNumber.toUpperCase(),
          style: AppTextStyle.bold(
            size: 13,
            color: AppColor.text(context).withValues(alpha: 0.4),
            letterSpacing: 2.0,
          ),
        ),
        const Gap(16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 58,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColor.kWhite.withValues(alpha: 0.05)
                    : AppColor.kBlack.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColor.text(context).withValues(alpha: 0.08),
                ),
              ),
              child: Row(
                children: [
                  CustomTextView(
                    text: '+91',
                    style: AppTextStyle.bold(
                      size: 17,
                      color: AppColor.text(context),
                    ),
                  ),
                  const Gap(6),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20,
                    color: AppColor.text(context).withValues(alpha: 0.4),
                  ),
                ],
              ),
            ),
            const Gap(14),
            Expanded(
              child: CustomTextField(
                controller: controller.tfPhoneController,
                hintText: '00000 00000',
                textInputType: TextInputType.phone,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 19,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
            ),
          ],
        ),
      ],
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
            color: AppColor.text(context).withValues(alpha: 0.4),
          ),
        ),
        const Gap(6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _footerLink(context.loc.termsOfService),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: CustomTextView(
                text: context.loc.and,
                style: AppTextStyle.regular(
                  size: 13,
                  color: AppColor.text(context).withValues(alpha: 0.4),
                ),
              ),
            ),
            _footerLink(context.loc.privacyPolicy),
          ],
        ),
      ],
    );
  }

  Widget _footerLink(String text) {
    return InkWell(
      onTap: () {},
      child: CustomTextView(
        text: text,
        style: AppTextStyle.bold(
          size: 13,
          color: AppColor.kPrimary,
          decoration: TextDecoration.underline,
          decorationColor: AppColor.kPrimary.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
