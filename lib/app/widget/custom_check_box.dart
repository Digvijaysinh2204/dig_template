import '../utils/import.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 20.0,
    this.activeColor = AppColor.kPrimary,
    this.borderColor,
    this.borderWidth = 1.5,
    this.borderRadius = 6.0,
    this.margin = const EdgeInsets.all(4),
    this.padding = const EdgeInsets.all(2),
  });
  final bool value;
  final ValueChanged<bool>? onChanged;
  final double size;
  final Color activeColor;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final effectiveBorderColor =
        borderColor ??
        (isDark ? AppColor.kDividerDark : AppColor.kDividerLight);
    return CustomInkWell(
      clickName: '${AppClick.checkBoxClick} ${AppClick.click}',
      onTap: () => onChanged?.call(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: size,
        width: size,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: value ? activeColor : AppColor.kTransparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: value ? activeColor : effectiveBorderColor,
            width: borderWidth,
          ),
        ),
        child: value
            ? Center(
                child: Icon(
                  Icons.check,
                  size: size * 0.7,
                  color: AppColor.kWhite,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
