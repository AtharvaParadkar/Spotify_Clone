# 📱 Spotify Clone — Frontend

The Flutter frontend for the Spotify Clone project. This cross-platform application delivers a Spotify-inspired music streaming UI with a rich dark theme, gradient accents, and a structured feature-based architecture.

---

## 🗂️ Project Structure

```
frontend/
├── lib/
│   ├── main.dart                        # App entry point
│   ├── core/
│   │   └── theme/
│   │       ├── app_pallete.dart         # Color palette & design tokens
│   │       └── theme.dart              # Global ThemeData configuration
│   └── features/
│       └── auth/
│           └── view/
│               ├── pages/
│               │   ├── signup_page.dart  # Sign Up screen
│               │   └── signin_page.dart  # Sign In screen
│               └── widgets/
│                   ├── auth_gradient_button.dart  # Gradient CTA button
│                   └── custom_field.dart           # Styled text input field
├── android/                             # Android platform files
├── ios/                                 # iOS platform files
├── web/                                 # Web platform files
├── windows/                             # Windows platform files
├── linux/                               # Linux platform files
├── macos/                               # macOS platform files
├── pubspec.yaml                         # Dependencies and app metadata
└── README.md                            # You are here
```

---

## 🚀 Tech Stack

| Technology        | Purpose                                  |
|-------------------|------------------------------------------|
| Flutter           | Cross-platform UI framework              |
| Dart `^3.10.3`    | Programming language                     |
| Material Design 3 | UI components and theming                |
| Cupertino Icons   | iOS-style icon pack                      |

---

## ✨ Features

- 🎨 **Dark Theme** — Spotify-inspired `#121212` background with gradient highlights
- 🖋️ **Custom Widgets** — Reusable `CustomField` and `AuthGradientButton` components
- 🔐 **Authentication Screens** — Sign Up and Sign In pages connected to the FastAPI backend
- 🌈 **Gradient Palette** — Purple → Pink → Peach gradient color system
- 📐 **Feature-Based Architecture** — Scalable folder structure organized by feature

---

## 🎨 Design System

The app uses a consistent global color palette defined in `app_pallete.dart`:

| Token                     | Color                              | Usage                       |
|---------------------------|------------------------------------|-----------------------------|
| `backgroundColor`         | `#121212` (RGBA 18,18,18)          | Scaffold background         |
| `cardColor`               | `#1E1E1E` (RGBA 30,30,30)          | Cards and surfaces          |
| `gradient1`               | `#BB3FDD` (Purple)                 | Gradient start              |
| `gradient2`               | `#FB6DA9` (Pink)                   | Gradient mid / border focus |
| `gradient3`               | `#FF9F7C` (Peach)                  | Gradient end                |
| `borderColor`             | `#343343`                          | Input field borders         |
| `whiteColor`              | `#FFFFFF`                          | Primary text                |
| `subtitleText`            | `#A7A7A7`                          | Secondary / subtitle text   |
| `inactiveBottomBarItem`   | `#ABABAB`                          | Inactive nav bar icons      |
| `inactiveSeekColor`       | `white38`                          | Seek bar inactive track     |

---

## 🛠️ Setup & Installation

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) — version `3.x` or later
- Dart SDK `^3.10.3` (comes bundled with Flutter)
- A connected device, emulator, or web browser

---

### 1. Navigate to the Frontend Directory

```bash
cd frontend
```

---

### 2. Install Dependencies

```bash
flutter pub get
```

---

### 3. Configure the Backend URL

Before running, make sure the backend API is running. Update the base API URL in your API service files to point to your backend:

```
http://localhost:8000
```

---

### 4. Run the App

```bash
# Run on a connected device or emulator
flutter run

# Run specifically on Chrome
flutter run -d chrome

# Run on Windows desktop
flutter run -d windows
```

---

## 📦 Dependencies

| Package           | Version   | Purpose                              |
|-------------------|-----------|--------------------------------------|
| `flutter`         | SDK       | Core framework                       |
| `cupertino_icons` | `^1.0.8`  | iOS-style icons                      |
| `flutter_lints`   | `^6.0.0`  | Recommended lint rules (dev)         |

> Run `flutter pub outdated` to check for newer versions.

---

## 🏗️ Architecture

This project follows a **feature-based clean architecture** pattern:

```
lib/
├── core/           # Shared utilities, themes, constants (app-wide)
└── features/       # Self-contained feature modules
    └── auth/       # Authentication feature
        └── view/   # UI layer — pages and widgets
```

Each feature will eventually contain:

- `view/` — UI (pages + widgets)
- `viewmodel/` — State management / business logic
- `repository/` — Data layer / API calls
- `models/` — Data models

---

## 📌 Roadmap

- [ ] Sign In screen connected to backend `/signin` endpoint
- [ ] JWT token storage and session management
- [ ] Home screen with song listing
- [ ] Music player with seek bar and controls
- [ ] Playlist management
- [ ] State management (Riverpod / BLoC)

---

## 📄 License

This project is open source and available under the [MIT License](../LICENSE).
