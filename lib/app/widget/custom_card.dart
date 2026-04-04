import '../utils/import.dart';
class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.height,
    this.padding = const EdgeInsets.all(12),
    this.radius = 12,
    this.borderColor,
    this.color,
    this.width,
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;
  final Color? color;
  final double? height;
  final double? width;
  final double radius;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width ?? double.infinity,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? (isDark ? AppColor.kScaffoldDark : AppColor.kWhite),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color:
              borderColor ??
              (isDark ? AppColor.kDividerDark : AppColor.kDividerLight),
        ),
      ),
      child: child,
    );
  }
}
