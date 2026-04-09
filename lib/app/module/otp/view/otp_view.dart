import 'package:pinput/pinput.dart';
import '../../../utils/import.dart';
import '../controller/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: AppTextStyle.bold(size: 22, color: AppColor.text(context)),
      decoration: BoxDecoration(
        color: AppColor.surface(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.text(context).withValues(alpha: 0.1),
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColor.kPrimary, width: 2),
      ),
    );

    return CustomScaffold(
      isAppBar: true,
      statusBarDarkIcons: !isDark,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const Gap(40),
            _buildLockIcon(context),
            const Gap(40),
            _buildHeader(context, loc),
            const Gap(48),
            _buildOtpInput(context, defaultPinTheme, focusedPinTheme),
            const Gap(48),
            _buildVerifyButton(context, loc),
            const Gap(32),
            _buildResendSection(context, loc),
          ],
        ).paddingSymmetric(horizontal: 24),
      ),
    );
  }

  Widget _buildLockIcon(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: AppColor.kPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Icon(
        Icons.lock_open_rounded,
        color: AppColor.kPrimary,
        size: 40,
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations loc) {
    return Column(
      children: [
        CustomTextView(
          text: loc.verifyOtp,
          textAlign: TextAlign.center,
          style: AppTextStyle.bold(size: 28, color: AppColor.text(context)),
        ),
        const Gap(12),
        CustomTextView(
          text: loc.otpSentTo('${loc.phonePrefix} ${controller.phoneNumber}'),
          textAlign: TextAlign.center,
          style: AppTextStyle.regular(
            size: 16,
            color: AppColor.text(context).withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildOtpInput(
    BuildContext context,
    PinTheme defaultPinTheme,
    PinTheme focusedPinTheme,
  ) {
    return Center(
      child: Pinput(
        length: 4,
        controller: controller.tfOtpController,
        focusNode: controller.focusNode,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        onCompleted: controller.verifyOtp,
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              width: 2,
              height: 20,
              color: AppColor.kPrimary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerifyButton(BuildContext context, AppLocalizations loc) {
    return Obx(
      () => CustomButton(
        width: double.infinity,
        clickName: AppClick.verifyOtp,
        text: loc.continueBtn.toUpperCase(),
        isLoading: controller.isLoading.value,
        onTap: () => controller.verifyOtp(controller.tfOtpController.text),
        bgColor: AppColor.kPrimary,
        textColors: AppColor.kWhite,
      ),
    );
  }

  Widget _buildResendSection(BuildContext context, AppLocalizations loc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextView(
          text: loc.didNotReceiveCode,
          style: AppTextStyle.medium(
            size: 14,
            color: AppColor.text(context).withValues(alpha: 0.5),
          ),
        ),
        const Gap(6),
        CustomInkWell(
          clickName: AppClick.resendOtp,
          onTap: controller.resendOtp,
          child: CustomTextView(
            text: loc.resendOtp,
            style: AppTextStyle.bold(size: 14, color: AppColor.kPrimary),
          ),
        ),
      ],
    );
  }
}
