# StreamPro

![CI](https://github.com/WaelLasheen/stream-pro/actions/workflows/main.yml/badge.svg)
![Flutter](https://img.shields.io/badge/Flutter-3.32.7-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.8-0175C2?logo=dart)
![Platform](https://img.shields.io/badge/platform-Android-3DDC84?logo=android)
![License](https://img.shields.io/badge/license-MIT-blue)

A production-grade video streaming client built with Flutter. StreamPro delivers
HLS video playback, threaded comments, creator tools (upload & manage videos),
watch history, subscriptions, and push notifications — all on top of a clean,
scalable, feature-first architecture.

---

## Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Testing](#testing)
- [CI/CD](#cicd)
- [Contributing](#contributing)
- [License](#license)

---

## Features

| Area | Capabilities |
| --- | --- |
| **Authentication** | Login & registration, secure token storage, automatic access-token refresh |
| **Home Feed** | Paginated video feed with category filters and shimmer loading states |
| **Search** | Video search with category filtering |
| **Video Playback** | HLS streaming via Chewie with custom controls: double-tap seek (±10s), mute, variable playback speed, fullscreen, auto-hiding UI |
| **Comments** | Add, edit, delete, optimistic UI, and nested **threaded replies** with per-thread loading/error states |
| **Profile** | Fetch profile, update name, upload avatar, delete account |
| **Channels** | Public channel pages, owner channel management, subscribers list |
| **Subscriptions** | Subscribe/unsubscribe with dedicated toggle state |
| **Likes** | Like videos and browse liked videos |
| **Watch History** | Automatic progress tracking with periodic sync and session de-duplication |
| **Video Management** | Multi-step upload (initiate → upload → complete), thumbnail upload, edit, publish/unpublish, delete |
| **Downloads** | Download videos to the device gallery with progress reporting |
| **Notifications** | Firebase Cloud Messaging with foreground, background, and cold-start tap routing |

---

## Screenshots

| Home | Video Details | Comments | Profile |
| --- | --- | --- | --- |
| _`docs/screenshots/home.png`_ | _`docs/screenshots/details.png`_ | _`docs/screenshots/comments.png`_ | _`docs/screenshots/profile.png`_ |

> Replace the placeholders above with real screenshots in a `docs/screenshots/` folder.

---

## Architecture

StreamPro follows **Clean Architecture** organized **feature-first**. Each feature
is an isolated module with three layers:

```
feature/
├── data/          # Datasources, DTO models, repository implementations
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/        # Pure business logic — no Flutter dependencies
│   ├── entities/
│   ├── repositories/   # Abstract contracts
│   └── use_cases/      # One class per action
└── presentation/  # UI + state management
    ├── controllers/    # Cubits
    ├── screens/
    ├── widgets/
    └── mappers/        # Entity → UI model / params
```

**Key principles**

- **Layered dependencies** — `presentation → domain ← data`. The domain layer is
  framework-agnostic and depends only on `dartz`.
- **Error handling as values** — repositories return `Either<Failure, T>`, so
  failures are explicit, type-safe, and never thrown across layer boundaries.
  A single `safeCall` wrapper converts exceptions into `Failure`s.
- **State management** — `flutter_bloc` / Cubit with immutable, `Equatable`
  states. Mutations use optimistic updates with rollback and guard against
  duplicate submissions and emits after disposal.
- **Dependency injection** — `get_it` with a per-feature registration module;
  repositories and use cases are lazy singletons, cubits are factories.
- **Networking** — `dio` with an interceptor pipeline: persistent cookie jar,
  bearer-token injection, and a queued 401 refresh-and-retry interceptor.

---

## Tech Stack

| Concern | Package |
| --- | --- |
| State management | `flutter_bloc`, `bloc` |
| Dependency injection | `get_it` |
| Functional types | `dartz` |
| Networking | `dio`, `dio_cookie_manager`, `cookie_jar`, `pretty_dio_logger` |
| Video | `video_player`, `chewie` |
| Backend services | `firebase_core`, `firebase_auth`, `firebase_messaging`, `firebase_crashlytics` |
| Notifications | `flutter_local_notifications` |
| Storage | `flutter_secure_storage`, `shared_preferences` |
| UI / Media | `flutter_screenutil`, `cached_network_image`, `shimmer`, `flutter_svg`, `gal` |
| Localization | `intl`, `flutter_localizations`, `intl_utils` |
| Utilities | `equatable`, `timeago`, `file_picker`, `path_provider`, `curved_navigation_bar` |

---

## Project Structure

```
lib/
├── main.dart                     # App entry: DI bootstrap, error handlers, MaterialApp
├── core/                         # Cross-cutting, feature-agnostic code
│   ├── di/                       # get_it setup + per-feature modules
│   ├── networking/               # ApiService, Dio interceptors, endpoint constants
│   ├── error/                    # Exceptions, Failures, safeCall
│   ├── routing/                  # AppRouter, route names, observers, 404 route
│   ├── theme/                    # AppTheme extension, ThemeData, typography
│   ├── services/                 # Storage, file picker, gallery abstractions
│   ├── notifications/            # FCM + local notification service
│   ├── shared/                   # Reusable widgets (errors, inputs, video cards…)
│   └── utils/                    # Extensions, constants, helpers, bloc observer
├── feature/                      # 15 self-contained feature modules
│   ├── auth/  home/  search/  category/  subscriptions/  Likes/
│   ├── video_details/  comments/  watch_history/  video_management/
│   ├── channel/  owner_channel/  profile/  notifications/  main/
├── generated/  l10n/             # Generated localizations (AR / EN)
└── firebase_options.dart
```

---

## Getting Started

### Prerequisites

- **Flutter** `3.32.7` (stable channel)
- **Dart** `^3.8.1`
- **Java JDK** `18` (for Android builds)
- **Android SDK** — `minSdk 23`, `compileSdk 36`
- A configured **Firebase** project (see [Configuration](#configuration))

### Installation

```bash
git clone https://github.com/WaelLasheen/stream-pro.git
cd stream-pro
flutter pub get
```

### Run

```bash
flutter run
```

### Build

```bash
# Split ABI release APKs
flutter build apk --release --split-per-abi
```

---

## Configuration

- **API base URL** — set in `lib/core/networking/api_constants.dart`.
- **Firebase** — provide platform options via `lib/firebase_options.dart`
  (generated with the FlutterFire CLI). Android is currently configured;
  additional platforms can be enabled by extending `DefaultFirebaseOptions`.
- **Localization** — ARB files live in `lib/l10n/` (`intl_en.arb`,
  `intl_ar.arb`). After editing, regenerate with:
  ```bash
  flutter gen-l10n
  ```
- **Theming** — design tokens are defined in
  `lib/core/theme/app_themes.dart` and exposed as a `ThemeExtension`
  (`context.appTheme`).

---

## Testing

```bash
# Static analysis
flutter analyze

# Unit / widget tests
flutter test
```

---

## CI/CD

The GitHub Actions pipeline (`.github/workflows/main.yml`) runs on every push
and pull request to `main` / `master`:

1. Checkout and set up Java 18 + Flutter 3.32.7 (with caching)
2. `flutter pub get`
3. `flutter analyze`
4. `flutter test`
5. Build split-ABI release APKs
6. Upload the APK as a build artifact
7. Distribute to **Firebase App Distribution**
8. Send a **Telegram** build notification

---

## Contributing

1. Fork the repository and create a feature branch.
2. Follow the existing **feature-first Clean Architecture** and the lint rules
   in `analysis_options.yaml`.
3. Keep the domain layer free of Flutter dependencies and return
   `Either<Failure, T>` from repositories.
4. Ensure `flutter analyze` and `flutter test` pass.
5. Open a pull request with a clear description.

Commit messages follow **Conventional Commits** (`feat:`, `fix:`, `refactor:`,
`style:`, `chore:`).

---

## License

Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for details.

---

<p align="center">Built with Flutter 💙</p>
