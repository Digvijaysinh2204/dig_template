import '../utils/import.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText = '',
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.isPassword = false,
    this.readOnly = false,
    this.validator,
    this.onTap,
    this.borderColor,
    this.textStyle,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.borderRadius = 16,
    this.inputFormatters,
    this.hintStyle,
    this.fillColor,
    this.enableBorderColor,
    this.focusBorderColor,
    this.disableBorderColor,
    this.focusNode,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.cursorColor,
    this.contentPadding,
    this.isDense,
    this.autofocus = false,
  });
  final bool autofocus;
  final Color? cursorColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final bool isPassword;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double borderRadius;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final int? maxLines;
  final Color? fillColor;
  final Color? enableBorderColor;
  final Color? focusBorderColor;
  final Color? disableBorderColor;
  final FocusNode? focusNode;
  final EdgeInsets scrollPadding;
  final EdgeInsets? contentPadding;
  final bool? isDense;
  @override
  Widget build(BuildContext context) {
    final textColor = AppColor.text(context);
    return TextFormField(
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      cursorColor: cursorColor ?? AppColor.kPrimary,
      maxLines: maxLines,
      scrollPadding: scrollPadding,
      onTap: onTap,
      decoration: InputDecoration(
        isDense: isDense,
        filled: true,
        fillColor:
            fillColor ??
            (Theme.of(context).brightness == Brightness.dark
                ? AppColor.kPrimary.withValues(alpha: 0.05)
                : AppColor.kWhite),
        suffixIcon: suffixIcon != null
            ? IconTheme(
                data: IconThemeData(color: textColor, size: 20),
                child: suffixIcon!,
              )
            : null,
        prefixIcon: prefixIcon != null
            ? IconTheme(
                data: IconThemeData(
                  color: AppColor.kPrimary.withValues(alpha: 0.8),
                  size: 20,
                ),
                child: prefixIcon!,
              )
            : null,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        hintText: hintText,
        hintStyle:
            hintStyle ??
            AppTextStyle.medium(
              size: 15,
              color: textColor.withValues(alpha: 0.3),
            ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                enableBorderColor ??
                (Theme.of(context).brightness == Brightness.dark
                    ? AppColor.kPrimary.withValues(alpha: 0.15)
                    : AppColor.text(context).withValues(alpha: 0.1)),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: focusBorderColor ?? AppColor.kPrimary,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.kError.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.5, color: AppColor.kError),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: disableBorderColor ?? AppColor.kDividerLight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      keyboardType: textInputType,
      textInputAction: textInputAction,
      controller: controller,
      obscureText: isPassword,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp(
            r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
          ),
        ),
        ...?inputFormatters,
      ],
      readOnly: readOnly,
      validator: validator,
      style: textStyle ?? AppTextStyle.semiBold(size: 16, color: textColor),
      onChanged: onChanged,
    );
  }
}
