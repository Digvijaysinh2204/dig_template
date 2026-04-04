import '../utils/import.dart';
class CustomRadioButton<T> extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.size = 20.0,
    this.activeColor = AppColor.kPrimary,
    this.borderColor,
    this.innerPadding = 4.0,
  });
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final double size;
  final Color activeColor;
  final Color? borderColor;
  final double innerPadding;
  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBorderColor =
        borderColor ??
        (isDark ? AppColor.kDividerDark : AppColor.kDividerLight);
    return CustomInkWell(
      clickName: 'radio_button',
      onTap: () => onChanged(value),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? activeColor : effectiveBorderColor,
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.all(innerPadding),
        child: isSelected
            ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: activeColor,
                ),
              )
            : null,
      ),
    );
  }
}
