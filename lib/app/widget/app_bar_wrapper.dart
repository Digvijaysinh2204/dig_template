import '../utils/import.dart';
import 'custom_back_button.dart';

class AppBarWrapper extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWrapper({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.appBarColor,
    this.statusBarDarkIcons = true,
    this.centerTitle = false,
    this.showBackButton = true,
    this.backButtonPressed,
    this.backButtonColor,
    this.backButtonBackgroundColor,
    this.leadingWidth,
    this.height,
  });
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool statusBarDarkIcons;
  final Color? appBarColor;
  final bool centerTitle;
  final bool showBackButton;
  final void Function()? backButtonPressed;
  final Color? backButtonColor;
  final Color? backButtonBackgroundColor;
  final double? leadingWidth;
  final double? height;
  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      leadingWidth: leadingWidth ?? 70,
      elevation: 0,
      centerTitle: centerTitle,
      backgroundColor: appBarColor ?? theme.appBarTheme.backgroundColor,
      surfaceTintColor: AppColor.kTransparent,
      automaticallyImplyLeading: false,
      toolbarHeight: preferredSize.height,
      title: title,
      actions: actions,
      titleSpacing: 0,
      leading: showBackButton
          ? Center(
              child: CustomBackButton(
                onPressed: backButtonPressed,
                color: backButtonBackgroundColor,
                iconColor: backButtonColor,
              ),
            )
          : leading,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColor.kTransparent,
        statusBarIconBrightness: statusBarDarkIcons
            ? Brightness.dark
            : Brightness.light,
        statusBarBrightness: statusBarDarkIcons
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarColor: AppColor.kTransparent,
        systemNavigationBarIconBrightness: statusBarDarkIcons
            ? Brightness.dark
            : Brightness.light,
      ),
    );
  }
}
