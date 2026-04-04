import '../utils/import.dart';
class Themes {
  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColor.kPrimary,
    scaffoldBackgroundColor: AppColor.kScaffoldLight,
    colorScheme: const ColorScheme.light(
      primary: AppColor.kPrimary,
      onPrimary: AppColor.kWhite,
      surface: AppColor.kWhite,
      onSurface: AppColor.kTextLight,
      error: AppColor.kError,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColor.kDividerLight,
      thickness: 1,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColor.kWhite,
      headerBackgroundColor: AppColor.kPrimary,
      headerForegroundColor: AppColor.kWhite,
      surfaceTintColor: AppColor.kTransparent,
      dayForegroundColor: const WidgetStatePropertyAll(AppColor.kTextLight),
      yearForegroundColor: const WidgetStatePropertyAll(AppColor.kTextLight),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: AppColor.kPrimary,
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: AppColor.kPrimary,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColor.kWhite,
      surfaceTintColor: AppColor.kTransparent,
      titleTextStyle: AppTextStyle.bold(size: 18, color: AppColor.kTextLight),
      contentTextStyle: AppTextStyle.regular(
        size: 14,
        color: AppColor.kTextLight,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColor.kWhite,
      surfaceTintColor: AppColor.kTransparent,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColor.kScaffoldLight,
      surfaceTintColor: AppColor.kTransparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColor.kTextLight),
      titleTextStyle: AppTextStyle.appBarTitle(color: AppColor.kTextLight),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColor.kTransparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColor.kTransparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
  );
  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColor.kPrimary,
    scaffoldBackgroundColor: AppColor.kScaffoldDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColor.kPrimary,
      onPrimary: AppColor.kWhite,
      surface: AppColor.kScaffoldDark,
      onSurface: AppColor.kTextDark,
      error: AppColor.kError,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColor.kDividerDark,
      thickness: 1,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColor.kScaffoldDark,
      headerBackgroundColor: AppColor.kPrimary,
      headerForegroundColor: AppColor.kWhite,
      surfaceTintColor: AppColor.kTransparent,
      dayForegroundColor: const WidgetStatePropertyAll(AppColor.kTextDark),
      yearForegroundColor: const WidgetStatePropertyAll(AppColor.kTextDark),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: AppColor.kPrimary,
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: AppColor.kPrimary,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColor.kScaffoldDark,
      surfaceTintColor: AppColor.kTransparent,
      titleTextStyle: AppTextStyle.bold(size: 18, color: AppColor.kTextDark),
      contentTextStyle: AppTextStyle.regular(
        size: 14,
        color: AppColor.kTextDark,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColor.kScaffoldDark,
      surfaceTintColor: AppColor.kTransparent,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColor.kScaffoldDark,
      surfaceTintColor: AppColor.kTransparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColor.kTextDark),
      titleTextStyle: AppTextStyle.appBarTitle(color: AppColor.kTextDark),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColor.kTransparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColor.kTransparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
  );
}
