# 🎨 Digital Asset Management (DAM) Guide

The project utilizes the **DIG CLI** to provide a type-safe, subfolder-aware asset generation system. This ensures zero-typo asset usage and organized folder-to-class mapping.

---

## 📁 Intelligent Folder Structure

The generator automatically converts your folder hierarchy into structured Dart classes.

| Folder Path | Generated Class Name |
| :--- | :--- |
| `assets/icons/svg/` | `IconsSvg` |
| `assets/icons/png/` | `IconsPng` |
| `assets/images/backgrounds/` | `ImagesBackgrounds` |
| `assets/fonts/inter/` | `FontsInter` |

### 🔍 Recommended Structure
```text
assets/
├── icons/            # App icons (svg/png)
├── images/           # Illustrations & Photos
├── background/       # Gradients & Pattern assets
└── fonts/            # Custom Typography (.ttf/.otf)
```

---

## 🚀 Commands & Workflow

### Development Cycles
| Action | Command | Purpose |
| :--- | :--- | :--- |
| **Sync Once** | `dg asset build` | Quick sync of all assets to code. |
| **Active Dev** | `dg asset watch` | Watches folders and auto-generates on every save. |

---

## 💻 Code Implementation

### 1. The Global Import
Instead of many small imports, use the centralized gateway:
```dart
import 'package:your_app/generated/assets.dart';
```

### 2. Standard Usage
```dart
// Type-safe SVG usage
SvgPicture.asset(IconsSvg.icBack);

// Type-safe Image usage
Image.asset(IconsPng.logo);

// Global list support (for dynamic rendering)
ListView.builder(
  itemCount: IconsSvg.values.length,
  itemBuilder: (ctx, idx) => SvgPicture.asset(IconsSvg.values[idx]),
);
```

---

## 🎯 Pro Features

### ⚡ Smart CamelCase
File names like `ic_home_active.svg` or `home-bg.png` are automatically normalized into `icHomeActive` and `homeBg` in Dart code.

### 🚫 Directory Skipping
To exclude specific folders (like raw designs or sketches), update `dig.yaml`:
```yaml
assets-dir: assets/
skip:
  - raw_designs
  - .trash
```

### 🏗️ Automatic Metadata
Each generated class includes a `values` list, which is perfect for building design systems or icon galleries within the app.

---
_Documentation optimized for the high-performance DIG architecture._
