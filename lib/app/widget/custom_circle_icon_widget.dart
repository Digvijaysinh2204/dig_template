import '../utils/import.dart';
class CustomCircleIconWidget extends StatelessWidget {
  const CustomCircleIconWidget({
    super.key,
    this.clickName,
    required this.onTap,
    this.color,
    required this.child,
    this.size = 40,
    this.padding,
    this.borderColor,
  });
  final String? clickName;
  final VoidCallback onTap;
  final Color? color;
  final Widget child;
  final double size;
  final EdgeInsets? padding;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return CustomInkWell(
      clickName: clickName != null
          ? '$clickName ${ClickEvents.click}'
          : '${ClickEvents.iconClick} ${ClickEvents.click}',
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        height: size,
        width: size,
        padding: padding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              color ??
              (isDark
                  ? AppColor.kWhite.withValues(alpha: 0.1)
                  : AppColor.kPrimary.withValues(alpha: 0.1)),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: Center(child: child),
      ),
    );
  }
}
