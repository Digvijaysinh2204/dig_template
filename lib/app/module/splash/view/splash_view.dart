import '../../../utils/import.dart';
import '../../module_export.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return CustomScaffold(
      isAppBar: false,
      appBarColor: AppColor.kTransparent,
      showBackButton: false,
      isSafeAreaTop: false,
      isSafeAreaBottom: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColor.kPrimary, AppColor.kSecondary],
          ),
        ),
        child: AnimatedBuilder(
          animation: controller.controller,
          builder: (_, _) {
            final v = controller.animation.value;
            return Stack(
              children: [
                Center(
                  child: Opacity(
                    opacity: v,
                    child: Transform.scale(
                      scale: 0.8 + (0.2 * v),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Opacity(
                            opacity: v > 0.4 ? (v - 0.4) * 1.66 : 0,
                            child: CustomTextView(
                              text: AppConstant.appName.toUpperCase(),
                              style: AppTextStyle.bold(
                                size: 48,
                                color: AppColor.kWhite,
                                letterSpacing: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: v > 0.8 ? (v - 0.8) * 5 : 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextView(
                          text: loc.author.toUpperCase(),
                          style: AppTextStyle.regular(
                            size: 11,
                            color: AppColor.kWhite.withValues(alpha: 0.7),
                            letterSpacing: 3,
                          ),
                        ),
                        const Gap(10),
                        CustomTextView(
                          text: AppConstant.author,
                          style: AppTextStyle.semiBold(
                            size: 16,
                            color: AppColor.kWhite,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
