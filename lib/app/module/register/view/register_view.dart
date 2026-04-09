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
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const Gap(30),
            _buildProfilePicker(context),
            const Gap(30),
            _buildHeader(context),
            const Gap(40),
            _buildInputs(context),
            const Gap(40),
            _buildRegisterButton(context),
          ],
        ).paddingSymmetric(horizontal: 24),
      ),
    );
  }

  Widget _buildProfilePicker(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Obx(
            () => Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: AppColor.surface(context),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColor.kPrimary.withValues(alpha: 0.2),
                  width: 2,
                ),
                image: controller.profileImage.value != null
                    ? DecorationImage(
                        image: FileImage(controller.profileImage.value!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: controller.profileImage.value == null
                  ? Icon(
                      Icons.person_rounded,
                      size: 50,
                      color: AppColor.text(context).withValues(alpha: 0.2),
                    )
                  : null,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CustomInkWell(
              clickName: AppClick.pickImage,
              onTap: () => controller.onPickProfile(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColor.kPrimary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: AppColor.kWhite,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
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
