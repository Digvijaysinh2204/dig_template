import '../utils/import.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    super.key,
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.borderRadius,
    this.padding,
    this.clickName = '',
  });
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final String clickName;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap == null
          ? null
          : () {
              if (clickName.isNotEmpty) {
                Get.find<AnalyticsService>().logClick(
                  widgetName: 'CustomInkWell',
                  clickName: clickName,
                );
              }
              onTap?.call();
            },
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
    );
  }
}
