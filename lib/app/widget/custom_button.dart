import '../utils/import.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.height,
    this.width,
    this.bgColor,
    this.isCenter = true,
    this.text,
    this.imagePath,
    this.customTextWidget,
    required this.clickName,
    this.borderRadius,
    this.textColors,
    this.border,
    this.useGradient = false,
    this.isLoading = false,
    this.isDisabled = false,
  });
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final Color? bgColor;
  final bool isCenter;
  final String? text;
  final Widget? customTextWidget;
  final String? imagePath;
  final String clickName;
  final BorderRadiusGeometry? borderRadius;
  final Color? textColors;
  final BoxBorder? border;
  final bool useGradient;
  final bool isLoading;
  final bool isDisabled;
  bool get _canTap => !isLoading && !isDisabled && onTap != null;
  @override
  Widget build(BuildContext context) {
    final effectiveBgColor = bgColor ?? Theme.of(context).colorScheme.onSurface;
    final bool isLightBg = effectiveBgColor.computeLuminance() > 0.5;
    final defaultContentColor = isLightBg ? Colors.black : Colors.white;
    final contentColor = (textColors ?? defaultContentColor).withValues(
      alpha: isDisabled ? 0.38 : 1.0,
    );
    return CustomInkWell(
      clickName: '$clickName ${AppClick.click}',
      onTap: _canTap ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height ?? 56,
        width: width,
        decoration: BoxDecoration(
          color: useGradient
              ? Colors.transparent
              : (isDisabled
                    ? Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.12)
                    : effectiveBgColor),
          gradient: _getGradient(isDisabled),
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          border: isDisabled
              ? Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.1),
                )
              : border,
        ),
        child: Center(
          child: isLoading
              ? _buildLoader(contentColor)
              : _buildBody(context, contentColor),
        ),
      ),
    );
  }

  Widget _buildLoader(Color color) => SizedBox(
    height: 22,
    width: 22,
    child: CircularProgressIndicator(strokeWidth: 2.5, color: color),
  );
  Widget _buildBody(BuildContext context, Color color) {
    return Row(
      mainAxisAlignment: isCenter
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imagePath != null) ...[
          imagePath!.toLowerCase().endsWith('.svg')
              ? SvgPicture.asset(
                  imagePath!,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  height: 20,
                )
              : Image.asset(imagePath!, height: 20, color: color),
          const Gap(10),
        ],
        customTextWidget ??
            CustomTextView(
              text: text ?? '',
              toUpperCase: true,
              style: AppTextStyle.semiBold(
                size: 15,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
      ],
    );
  }

  Gradient? _getGradient(bool disabled) {
    if (disabled || !useGradient) return null;
    return const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xFFBAA9FF), Color(0xFF604ABD)],
    );
  }
}
