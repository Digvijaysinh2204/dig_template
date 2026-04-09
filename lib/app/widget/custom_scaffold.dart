import '../utils/import.dart';
import 'app_bar_wrapper.dart';

class CustomScaffold extends StatelessWidget {
  static Widget? defaultBackgroundWidget;
  static Widget? defaultDarkBackgroundWidget;
  static DecorationImage? defaultBackgroundImage;
  static DecorationImage? defaultDarkBackgroundImage;
  const CustomScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.isSafeAreaTop = true,
    this.isSafeAreaBottom = true,
    this.isAppBar = true,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backButtonPressed,
    this.backgroundColor,
    this.appBarColor,
    this.backButtonColor,
    this.backButtonBackgroundColor,
    this.statusBarDarkIcons,
    this.appBarHeight,
    this.centerTitle = false,
    this.resizeToAvoidBottomInset,
    this.backgroundImage,
    this.backgroundWidget,
    this.darkBackgroundImage,
    this.darkBackgroundWidget,
    this.extendBodyBehindAppBar = false,
  });
  final Widget body;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final bool isAppBar;
  final bool isSafeAreaTop;
  final bool isSafeAreaBottom;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final void Function()? backButtonPressed;
  final Color? backgroundColor;
  final Color? appBarColor;
  final Color? backButtonColor;
  final Color? backButtonBackgroundColor;
  final bool? statusBarDarkIcons;
  final double? appBarHeight;
  final bool centerTitle;
  final bool? resizeToAvoidBottomInset;
  final DecorationImage? backgroundImage;
  final Widget? backgroundWidget;
  final DecorationImage? darkBackgroundImage;
  final Widget? darkBackgroundWidget;
  final bool extendBodyBehindAppBar;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bool useDarkIcons = statusBarDarkIcons ?? !isDark;
    final Widget? bg = _getBackground(isDark);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColor.kTransparent,
        statusBarIconBrightness: useDarkIcons
            ? Brightness.dark
            : Brightness.light,
        statusBarBrightness: useDarkIcons ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: AppColor.kTransparent,
        systemNavigationBarIconBrightness: useDarkIcons
            ? Brightness.dark
            : Brightness.light,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: bg == null
            ? _buildScaffold(context, null, useDarkIcons, theme)
            : Stack(
                fit: StackFit.expand,
                children: [
                  bg,
                  _buildScaffold(context, bg, useDarkIcons, theme),
                ],
              ),
      ),
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    Widget? bg,
    bool useDarkIcons,
    ThemeData theme,
  ) {
    final hasBg = bg != null;
    return Scaffold(
      backgroundColor: hasBg
          ? AppColor.kTransparent
          : (backgroundColor ?? theme.scaffoldBackgroundColor),
      extendBodyBehindAppBar: hasBg || extendBodyBehindAppBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      appBar: isAppBar
          ? AppBarWrapper(
              title: title,
              actions: actions,
              leading: leading,
              showBackButton: showBackButton,
              backButtonPressed: backButtonPressed,
              backButtonColor: backButtonColor,
              backButtonBackgroundColor: backButtonBackgroundColor,
              appBarColor: hasBg
                  ? (appBarColor ?? AppColor.kTransparent)
                  : appBarColor,
              statusBarDarkIcons: useDarkIcons,
              centerTitle: centerTitle,
              height: appBarHeight,
            )
          : null,
      body: SafeArea(
        top: isSafeAreaTop && !hasBg && !extendBodyBehindAppBar,
        bottom: isSafeAreaBottom,
        child: body,
      ),
    );
  }

  Widget? _getBackground(bool isDark) {
    if (isDark) {
      if (darkBackgroundWidget != null) return darkBackgroundWidget;
      if (darkBackgroundImage != null) return _bgImg(darkBackgroundImage!);
      if (defaultDarkBackgroundWidget != null)
        return defaultDarkBackgroundWidget;
      if (defaultDarkBackgroundImage != null)
        return _bgImg(defaultDarkBackgroundImage!);
      if (AppConstant.defaultDarkBg.isNotEmpty)
        return _bgImgPath(AppConstant.defaultDarkBg);
    } else {
      if (backgroundWidget != null) return backgroundWidget;
      if (backgroundImage != null) return _bgImg(backgroundImage!);
      if (defaultBackgroundWidget != null) return defaultBackgroundWidget;
      if (defaultBackgroundImage != null)
        return _bgImg(defaultBackgroundImage!);
      if (AppConstant.defaultLightBg.isNotEmpty)
        return _bgImgPath(AppConstant.defaultLightBg);
    }
    return null;
  }

  Widget _bgImg(DecorationImage img) => DecoratedBox(
    decoration: BoxDecoration(image: img),
    child: const SizedBox.expand(),
  );
  Widget _bgImgPath(String path) => DecoratedBox(
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
    ),
    child: const SizedBox.expand(),
  );
}
