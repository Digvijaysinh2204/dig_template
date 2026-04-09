library;

/// Centralized Analytics & Click Tracking Constants
///
/// TO ADD A NEW CLICK EVENT: Add a new static string to [AppClick].
/// TO ADD A NEW FIREBASE EVENT: Add a new static string to [AnalyticsEvent].
/// TO ADD A NEW PARAMETER: Add a new static string to [AnalyticsParam].

class AppClick {
  AppClick._();

  // Auth & Onboarding
  static const String loginContinue = 'login_continue';
  static const String verifyOtp = 'verify_otp';
  static const String resendOtp = 'resend_otp';
  static const String registerSubmit = 'register_submit';

  // Navigation & Tabs
  static const String dashboardTab = 'dashboard_tab';
  static const String moreTab = 'more_tab';

  // More Section / Settings
  static const String openProfile = 'open_profile';
  static const String changeTheme = 'change_theme';
  static const String changeLanguage = 'change_language';
  static const String privacyPolicy = 'privacy_policy';
  static const String termsOfService = 'terms_of_service';
  static const String logout = 'logout';
  static const String deleteAccount = 'delete_account';
  static const String toggleBiometric = 'toggle_biometric';

  // Common / Global
  static const String backButton = 'back_button';
  static const String backButtonClick = 'back_button_click';
  static const String checkBoxClick = 'check_box_click';
  static const String click = 'click';
  static const String iconClick = 'icon_click';
  static const String readMoreClick = 'read_more_click';
  static const String showLessClick = 'show_less_click';
  static const String searchClick = 'search_click';
}

class AnalyticsEvent {
  AnalyticsEvent._();

  static const String userIdentify = 'user_identify';
  static const String userLogout = 'user_logout';
  static const String sessionStart = 'session_start';
  static const String screenView = 'screen_view';
  static const String widgetClick = 'widget_click';
}

class AnalyticsParam {
  AnalyticsParam._();

  static const String userData = 'user_data';
  static const String userId = 'user_id';
  static const String deviceId = 'device_id';
  static const String platform = 'platform';
  static const String appVersion = 'app_version';
  static const String screenName = 'screen_name';
  static const String screenClass = 'screen_class';
  static const String widgetName = 'widget_name';
  static const String clickName = 'click_name';
  static const String timestamp = 'timestamp';
}
