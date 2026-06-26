# 📱 Spotify Clone — Frontend

The cross-platform Flutter application for the Spotify Clone project. It features a responsive UI inspired by the Spotify design language, complete with a rich dark theme, custom audio player overlays, background playback, and offline local cache sync.

---

## 🗂️ Project Structure

```text
frontend/
├── lib/
│   ├── main.dart                        # Application entry point (initializes Hive and audio services)
│   ├── core/                            # Global core modules shared across features
│   │   ├── theme/
│   │   │   ├── app_pallete.dart         # Hex design tokens & theme palette
│   │   │   └── theme.dart              # Global ThemeData configuration (Dark Mode)
│   │   ├── failure/
│   │   │   └── failure.dart             # API failure handling wrapper
│   │   ├── utils.dart                   # Shared utils (color converters, file picker assistants)
│   │   └── providers/
│   │       ├── current_user_notifier.dart # Riverpod notifier for authenticated user profile
│   │       └── current_song_notifier.dart # Player notifier managing audio stream, player states, seek positions
│   └── features/
│       ├── auth/                        # User authentication module
│       │   ├── model/                   # User and auth state models
│       │   ├── repository/              # Network client for login, registration, and profile fetch
│       │   ├── view/
│       │   │   ├── pages/               # SignupPage and SignInPage screens
│       │   │   └── widgets/             # Reusable CustomField forms and AuthGradientButton CTA
│       │   └── viewmodel/               # AuthViewModel managing auth flows and saving JWT to Shared Preferences
│       └── home/                        # Music dashboards, player, library and track upload module
│           ├── models/                  # Audio track metadata models
│           ├── repositories/            # HomeRepository (remote HTTP API) and HomeLocalRepository (Hive caching)
│           ├── view/
│           │   ├── pages/               # HomePage navigation hub, SongsPage list, LibraryPage, UploadSongPage
│           │   └── widgets/             # MusicSlab (floating footer), MusicPlayer (detail sheet), AudioWave
│           └── viewmodel/               # HomeViewModel coordinating song streams, uploads, and favorites
├── android/                             # Platform folder containing native android background player rules
├── ios/                                 # Platform folder containing native iOS audio session configurations
├── pubspec.yaml                         # App metadata, assets declaration, and external package dependencies
└── README.md                            # You are here
```

---

## 🚀 Tech Stack & Core Libraries

| Package | Purpose |
| :--- | :--- |
| **Flutter / Dart** | Cross-platform client development (Material 3 layout) |
| **flutter_riverpod** | Global state management |
| **riverpod_generator** | Code-generation tool to automatically create state providers |
| **http** | High-level HTTP client for REST API communication |
| **fpdart** | Functional programming tools (using `Either` for success/failure handling) |
| **shared_preferences** | Cache user token (JWT) locally to persist user login sessions |
| **hive** | Fast, lightweight NoSQL database used to cache recently played tracks locally |
| **just_audio** | Feature-rich audio player for local/network file streaming |
| **just_audio_background** | Configures background playback service and lock screen notification media controls |
| **audio_waveforms** | Displays custom, interactive audio waveforms during play sessions |
| **flex_color_picker** | Color picker used when uploading tracks to choose the player theme color |
| **dotted_border** | Dashed visual indicator box for local file upload selection |
| **file_picker** | Picks audio files and cover art image files from device directories |

---

## 🎨 Design System

The app utilizes a design system defined in `app_pallete.dart` featuring a clean, modern dark appearance:

| Color Token | Value | Primary Usage |
| :--- | :--- | :--- |
| `backgroundColor` | `#121212` | Main page scaffold backgrounds |
| `cardColor` | `#1E1E1E` | Card components, container boxes, and surfaces |
| `gradient1` | `#BB3FDD` | Purple accent color (Gradient start) |
| `gradient2` | `#FB6DA9` | Pink accent color (Gradient middle / focused border) |
| `gradient3` | `#FF9F7C` | Peach accent color (Gradient end) |
| `borderColor` | `#343343` | Inactive text field border contours |
| `whiteColor` | `#FFFFFF` | Primary headers and text labels |
| `subtitleText` | `#A7A7A7` | Secondary text, track metadata, and subtitles |
| `inactiveBottomBarItem` | `#ABABAB` | Secondary icons and navigation buttons |

---

## 🛠️ Setup & Run

### 1. Install Flutter

Ensure you have a recent version of Flutter SDK installed. This project targets Dart SDK `^3.10.3` and Flutter `3.x`.

```bash
flutter --version
```

### 2. Configure Backend Endpoint

Open `lib/core/constants/api_constants.dart`. Set `baseUrl` to match your active FastAPI backend address:
* For local desktop platforms / simulators: `http://127.0.0.1:8000`
* For physical testing devices: Update to match your host machine's IP (e.g. `http://192.168.1.xxx:8000`)
* For tunnel routing: Insert your public ngrok URL (e.g. `https://xxx.ngrok-free.dev`)

### 3. Install Dependencies

Navigate to the frontend directory and fetch the packages:

```bash
cd frontend
flutter pub get
```

### 4. Run Code Generation

The project relies on Riverpod's automatic code generators (`riverpod_generator`). Before building the app, compile the state provider files:

```bash
# One-time build:
dart run build_runner build --delete-conflicting-outputs

# Continuous watch (automatically rebuilds on file changes):
dart run build_runner watch --delete-conflicting-outputs
```

### 5. Launch the Application

Make sure your emulator is booted or a physical device is connected, then run:

```bash
# Run on default connected device
flutter run

# Run target web client
flutter run -d chrome
```

---

## 🏗️ State & Storage Architecture

### Global State Flow
The application state revolves around **Riverpod Notifiers**:
1. **User Auth Session (`currentUserNotifierProvider`)**: Synchronizes authenticated state, fetches profile updates from `/auth/`, and stores the authorization token in `SharedPreferences`.
2. **Track Playback Session (`currentSongNotifierProvider`)**: Directs `just_audio` player instances, controls stream URLs, updates seeking time, and updates player bar styling (leveraging the color hex value from the song entity).

### Caching Architecture
- **Hive Database**: When a song is selected, the entity metadata is cached locally in Hive using `HomeLocalRepository`.
- **Local library fallback**: Users can fetch their recently played songs directly from the local Hive box when offline.
- **Audio service integration**: Audio files are streamed asynchronously with buffer checks, and lock screen media details are managed automatically using `just_audio_background`.

---

## 📄 License

This project is open source and available under the [MIT License](../LICENSE).
