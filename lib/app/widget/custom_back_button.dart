import '../utils/import.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onPressed,
    this.color,
    this.iconColor,
  });
  final Color? color;
  final Color? iconColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? AppColor.kTextDark : AppColor.kTextLight;
    return CustomInkWell(
      clickName: '${AppClick.backButtonClick} ${AppClick.click}',
      onTap: onPressed ?? () => Get.back(closeOverlays: true),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: color ?? textColor.withValues(alpha: 0.05),
          shape: BoxShape.circle,
        ),
        child: Icon(
          GetPlatform.isIOS
              ? Icons.arrow_back_ios_new_rounded
              : Icons.arrow_back_rounded,
          size: 18,
          color: iconColor ?? textColor,
        ),
      ),
    );
  }
}
