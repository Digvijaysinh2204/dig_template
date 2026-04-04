# 🚀 Production Setup Guide: Firebase & Notifications

Follow these steps to correctly configure external integrations for production use.

---

## 1. 🔥 Firebase Configuration

If you have already initialized Firebase via FlutterFire CLI, most of this is done. If not, follow these manual steps:

### Android (`android/app/`)
- Place your `google-services.json` inside `android/app/`.
- Verify the following in `android/build.gradle`:
  ```gradle
  dependencies {
      classpath 'com.google.gms:google-services:4.4.0' // Or latest
  }
  ```
- Verify the following in `android/app/build.gradle` (at the bottom):
  ```gradle
  apply plugin: 'com.google.gms.google-services'
  ```

### iOS (`ios/Runner/`)
- Place your `GoogleService-Info.plist` inside `ios/Runner/` via Xcode.
- Ensure the bundle ID in Firebase matches your project bundle ID.

---

## 2. 🔔 Notifications Setup

### Android Setup
- **Notification Icon**: Ensure you have a transparent white icon at `android/app/src/main/res/drawable/notification.png`.
- **Channel ID**: The `NotificationService` uses `default_notification_channel_id`. You can customize this in `lib/app/services/notification_service.dart`.

### iOS Setup
- In Xcode, go to **Signing & Capabilities**.
- Add **Push Notifications**.
- Add **Background Modes** and check `Remote notifications`.

---

## ⚙️ App Constants

Ensure `lib/app/constants/app_constant.dart` has the following toggled correctly:
- `isFirebaseEnabled = true;`
- `apiBaseUrl = 'https://api.yourdomain.com';`

---

## ✅ Deployment Checklist
- [ ] Firebase project created and keys added.
- [ ] Proguard rules configured for release.
- [ ] Play Store/App Store bundle IDs verified.
