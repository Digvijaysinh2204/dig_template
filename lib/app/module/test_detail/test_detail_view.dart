import '../../utils/import.dart';

class TestDetailController extends GetxController {
  final userData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    userData.value = Get.arguments ?? {'name': 'Unknown', 'id': '0'};
    super.onInit();
  }

  void pushNext(String id) {
    LocalNotificationService.instance.show(
      title: 'Deep Link Triggered',
      body: 'Opening details for User $id',
      payload: {'type': 'user_detail', 'id': id, 'name': 'User $id'},
    );
  }
}

class TestDetailView extends GetView<TestDetailController> {
  const TestDetailView({super.key});

  @override
  String? get tag => Get.parameters['id'] ?? Get.arguments?['id']?.toString();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: CustomTextView(
        text: 'User Insight',
        style: AppTextStyle.bold(size: 20, color: AppColor.text(context)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(40),
            _buildUserCard(context),
            const Gap(40),
            _buildActionSection(context),
          ],
        ).paddingSymmetric(horizontal: 24),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.kPrimary, AppColor.kPrimary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColor.kPrimary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person_rounded, size: 40, color: Colors.white),
          ),
          const Gap(20),
          Obx(
            () => CustomTextView(
              text: controller.userData['name'] ?? 'No Name',
              style: AppTextStyle.bold(size: 28, color: Colors.white),
            ),
          ),
          const Gap(8),
          Obx(
            () => CustomTextView(
              text: 'Active Profile ID: ${controller.userData['id']}',
              style: AppTextStyle.medium(
                size: 16,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextView(
          text: 'Trigger Next Stack Level',
          style: AppTextStyle.bold(size: 18, color: AppColor.text(context)),
        ),
        const Gap(8),
        CustomTextView(
          text:
              'Tap to send a notification and push a new route onto the current stack.',
          style: AppTextStyle.regular(
            size: 14,
            color: AppColor.text(context).withValues(alpha: 0.5),
          ),
        ),
        const Gap(24),
        Row(
          children: [
            Expanded(child: _buildNavButton('Open User 1', '1')),
            const Gap(12),
            Expanded(child: _buildNavButton('Open User 2', '2')),
            const Gap(12),
            Expanded(child: _buildNavButton('Open User 3', '3')),
          ],
        ),
      ],
    );
  }

  Widget _buildNavButton(String label, String id) {
    return ElevatedButton(
      onPressed: () => controller.pushNext(id),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.surface(Get.context!),
        foregroundColor: AppColor.kPrimary,
        elevation: 0,
        side: BorderSide(color: AppColor.kPrimary.withValues(alpha: 0.2)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
