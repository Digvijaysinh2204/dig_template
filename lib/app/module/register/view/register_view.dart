import '../../../utils/import.dart';
import '../controller/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isAppBar: true,
      title: CustomTextView(text: context.loc.register),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(30),
            _buildHeader(context),
            const Gap(40),
            _buildInputs(context),
            const Gap(40),
            _buildRegisterButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextView(
          text: context.loc.completeProfile,
          style: AppTextStyle.bold(size: 26, color: AppColor.text(context)),
        ),
        const Gap(10),
        CustomTextView(
          text: context.loc.provideDetailsToContinue,
          style: AppTextStyle.regular(
            size: 16,
            color: AppColor.text(context).withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildInputs(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: controller.tfNameController,
          hintText: context.loc.fullName,
          prefixIcon: const Icon(Icons.person_outline_rounded),
          textInputAction: TextInputAction.next,
        ),
        const Gap(20),
        CustomTextField(
          controller: controller.tfEmailController,
          hintText: context.loc.emailAddress,
          prefixIcon: const Icon(Icons.email_outlined),
          textInputType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => controller.onRegister(),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Obx(
      () => CustomButton(
        width: double.infinity,
        clickName: AppClick.registerSubmit,
        text: context.loc.register.toUpperCase(),
        isLoading: controller.isLoading.value,
        onTap: controller.onRegister,
        bgColor: AppColor.kPrimary,
        textColors: AppColor.kWhite,
      ),
    );
  }
}
