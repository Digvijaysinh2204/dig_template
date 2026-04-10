# 🏗️ Premium Flutter Enterprise Boilerplate

This project follows a **Clean Modular GetX Architecture**, designed for high-performance, maintainability, and enterprise-grade scalability. Every directory follows a strict "Single Responsibility Principle".

---

## 🏛️ Project Architecture (Folder-by-Folder)

### 📂 `lib/app/`
The heart of the application logic.

#### 1. `api/` (Data Layer)
*   **Purpose**: Handles all network-related logic.
*   **Networking**: Uses `GetConnect` with a custom `ApiService`.
*   **Result Pattern**: Wraps API responses in a `Result` type (`Success` or `Failure`) to prevent runtime crashes and handle error states gracefully.

#### 2. `constants/` (Configuration Layer)
*   **Purpose**: Centralized storage for static keys, environment toggles, and API endpoints. 
*   **Key Files**: `AppConstant` (Firebase toggle, Base URLs) and `AppConfig` (App-wide settings).

#### 3. `module/` (Feature Layer)
*   **Purpose**: Follows a **Feature-First** modular structure.
*   **Pattern**: Each module contains its own `Binding`, `Controller`, and `View`.
*   **Exports**: Uses `module_export.dart` to flatten imports and make features easily accessible.

#### 4. `routes/` (Routing Layer)
*   **Purpose**: Decouples navigation from views.
*   **AppRoute**: Contains static string constants for route names.
*   **AppPage**: Consolidates `GetPage` definitions, bindings, and dynamic segments (:id).

#### 5. `services/` (Infrastructure Layer)
*   **Purpose**: Global singletons that manage app-wide lifecycles (FCM, Local Notifications, Storage, Crypto, Network monitoring).
*   **Status**: Services are initialized at startup (Splash) and persist through the app session.

#### 6. `storage/` (Persistence Layer)
*   **Purpose**: Wrapper around `GetStorage` or `Hive`.
*   **Pattern**: Uses `StoreKey` to avoid hardcoded string keys for local cache.

#### 7. `theme/` (Design System)
*   **Purpose**: Contains the typography (`AppTextStyle`) and color tokens (`AppColor`).
*   **Best Practice**: Uses `context.theme` and semantic color names for automatic Light/Dark mode support.

#### 8. `widget/` (Shared Component Layer)
*   **Purpose**: Reusable UI components used across multiple modules (Buttons, TextFields, Scaffolds, Loaders).

---

## 🔄 Core System Workflows

### 🛤️ Routing & Navigation
We use **Named Routing** for 100% deep-link compatibility.
- **Normal**: `Get.toNamed(AppRoute.auth)`
- **Multiplexed (A->B->C)**: `/TestDetail/:id` pattern with unique GetX tagging.

### 🌐 API Communication
1.  Call `ApiService` method.
2.  Service returns a `Result` object.
3.  Controller handles the result:
    ```dart
    final result = await Get.find<ApiService>().getData();
    result.when(
      success: (data) => _handleData(data),
      failure: (error) => _showError(error),
    );
    ```

### 🔔 Integrated Notifications
- **FcmService**: Manages Firebase lifecycle.
- **LocalNotificationService**: Manages local display & tap detection.
- **NotificationRouter**: Central hub to handle all app-wide redirections based on payload.

---

## 🚀 Quality Standards
- **Zero-Comment Policy**: The code is kept self-documenting through clean variable and class naming.
- **Fenix Bindings**: Controllers are initialized only when needed and disposed of when the route is removed.
- **Type-Safe Assets**: Uses the `dg` CLI to generate classes for local assets, preventing string-path errors.

---

## 📂 Root Directories Summary
- `assets/`: Organized by category (icons, images, fonts).
- `generated/`: Auto-generated code for assets and localizations.
- `lib/`: The main source code.
- `test/`: Unit and widget tests.

---
_Engineered for performance. Documented for clarity._
