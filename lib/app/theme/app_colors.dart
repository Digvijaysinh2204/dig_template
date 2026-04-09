import '../utils/import.dart';
class AppColor {
  static const Color kPrimary = Color(0XFF9D3D6C);
  static const Color kSecondary = Color(0xFF9A80AF);
  static const Color kWhite = Color(0xFFFFFFFF);
  static const Color kBlack = Color(0xFF000000);
  static const Color kTransparent = Colors.transparent;
  static const Color kScaffoldLight = Color(0xFFFFFFFF);
  static const Color kScaffoldDark = Color(0xFF161A25);
  static const Color kTextLight = Color(0xFF030303);
  static const Color kTextDark = Color(0xFFFFFFFF);
  static const Color kError = Color(0xFFFF5757);
  static const Color kSuccess = Color(0XFF27AE60);
  static const Color kWarning = Color(0XFFF2994A);
  static const Color kDividerLight = Color(0x1A030303);
  static const Color kDividerDark = Color(0x1AFFFFFF);
  static Color text(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? kTextDark
          : kTextLight;

  static Color divider(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? kDividerDark
          : kDividerLight;

  static Color scaffold(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? kScaffoldDark
          : kScaffoldLight;

  static Color surface(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? kWhite.withValues(alpha: 0.05)
          : kBlack.withValues(alpha: 0.03);
}
