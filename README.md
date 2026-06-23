# Contextual Silence

[![CI](https://github.com/AB69D/contextual-phone-silence/actions/workflows/ci.yml/badge.svg)](https://github.com/AB69D/contextual-phone-silence/actions/workflows/ci.yml)
[![Flutter](https://img.shields.io/badge/Flutter-3.22%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.4%2B-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Android](https://img.shields.io/badge/Android-API%2026%2B-3DDC84?logo=android&logoColor=white)](https://developer.android.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Contextual Silence** automatically silences your Android phone based on your calendar — so you never forget to mute before a meeting again.

The app reads your device calendar, matches event titles against a configurable keyword list, and schedules exact alarms to silence and restore your ringer at precisely the right moment. It works entirely on-device with no server required.

---

## Screenshots

> _Screenshots coming soon. See the [feature breakdown](#features) below for a full description of every screen._

---

## Features

### Calendar-Aware Auto-Silence
Reads your Google / device calendar and silences the phone automatically before each matched event. A configurable lead-time lets the phone go quiet a set number of minutes before the event starts.

### Keyword Tier Matching
Every calendar event title is scanned against a keyword list. Each keyword maps to one of three tiers:

| Tier | Behaviour |
|------|-----------|
| **Full Silent** | Phone set to silent mode (DND) |
| **Vibrate** | Phone set to vibrate only |
| **Skip** | Event is ignored, phone left unchanged |

Keywords and tiers can be enabled or disabled individually without deleting them.

### Silence Profiles
Named profiles (e.g., *Work*, *Gym*, *Personal*) let you group behaviour and keyword overrides. One profile is active at a time; switching profiles changes which keyword rules apply.

### VIP Contacts — Bypass List
Add contacts to a VIP list. Their calls ring through even when the phone is silenced — useful for family or on-call colleagues.

### Missed Digest
After a silence session ends, a notification summarises missed calls and messages so you can catch up instantly. The digest can be toggled in Settings.

### Manual Silence
A **Silence now** button on the home screen starts a silence session immediately, without a calendar event — useful for ad-hoc meetings or focus time.

### Auto-Restore
When a matched calendar event ends the app restores your previous ringer mode automatically. No need to remember to un-mute.

### Custom Schedules
Create schedule rules that combine a calendar source, a keyword filter, and a target profile. Multiple schedules coexist — for example, your work calendar silences fully while your personal calendar only vibrates.

### Session History
Every silence session (automatic or manual) is logged with its start / end time, duration, triggering event title, and missed-call count. Aggregate stats — total sessions, total hours protected, total calls blocked — are shown in a header bar.

### Boot-Resilient Scheduling
Exact alarms are rescheduled automatically after a device reboot, app update, or quick-boot so no meeting is missed after a restart.

### Battery Optimisation Handling
The app detects and navigates to the battery optimisation exemption screen for major OEMs (Samsung, Xiaomi / MIUI, Huawei, ColorOS, OnePlus) so background scheduling works reliably.

### Permission Health Check
The Settings screen shows the live status of three critical permissions and surfaces a one-tap shortcut to fix any that are missing:

- Do Not Disturb access
- Exact alarm scheduling
- Battery optimisation exclusion

---

## Architecture

The project follows **Clean Architecture** with three layers and MVVM presentation.

```
lib/
├── core/           # DI (GetIt), constants, error types, utilities
├── data/           # Drift SQLite database, repositories, data-sources
│   ├── database/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/         # Entities, repository interfaces, use-cases
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/   # Screens, ViewModels (Provider), theme, router
    ├── router/     # go_router
    ├── screens/
    ├── theme/
    └── widgets/
```

Android-side native code lives in `android/app/src/main/kotlin/` and is bridged to Flutter via `MethodChannel`:

| Kotlin class | Responsibility |
|---|---|
| `AlarmScheduler` | Schedule / cancel exact alarms |
| `SilenceAlarmReceiver` | BroadcastReceiver — fires at event start / end |
| `AudioStateManager` | Read and set the ringer mode |
| `CalendarSyncWorker` | WorkManager periodic sync (every 15 min) |
| `BootReceiver` | Reschedule alarms after reboot |
| `OemBatteryHelper` | OEM-specific battery optimisation intents |

---

## Tech Stack

| Concern | Library / Version |
|---|---|
| UI | Flutter · Material 3 |
| State management | Provider 6 |
| Navigation | go_router 13 |
| Local database | Drift 2 (SQLite) |
| Dependency injection | GetIt 7 |
| Background work | WorkManager 0.5 + flutter_foreground_task 8 |
| Notifications | flutter_local_notifications 17 |
| Preferences | shared_preferences 2 |
| Contacts | flutter_contacts 1 |
| Code generation | build_runner · freezed · json_serializable |

---

## Requirements

| | Minimum |
|---|---|
| Flutter | 3.22.0 |
| Dart | 3.4.0 |
| Android SDK | API 26 (Android 8.0 Oreo) |
| Target SDK | API 35 (Android 15) |
| Java | 17 |

---

## Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/AB69D/contextual-phone-silence.git
cd contextual-phone-silence
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run code generation

Drift table classes and Freezed models are generated — run this once and again after any schema change:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run the app

```bash
flutter run
```

On first launch, the onboarding flow guides you through granting the required permissions.

### 5. Build a release APK

```bash
flutter build apk --release
```

> Note: you must configure a signing key in `android/app/build.gradle.kts` before a production release. See the [Android signing docs](https://developer.android.com/studio/publish/app-signing) for details.

---

## Permissions

| Permission | Why it is needed |
|---|---|
| `READ_CALENDAR` | Read calendar events to determine when to silence |
| `ACCESS_NOTIFICATION_POLICY` | Control the Do Not Disturb / ringer mode |
| `SCHEDULE_EXACT_ALARM` / `USE_EXACT_ALARM` | Fire alarms at the precise start/end of events |
| `RECEIVE_BOOT_COMPLETED` | Reschedule alarms after a device restart |
| `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` | Keep background scheduling reliable |
| `FOREGROUND_SERVICE` | Maintain service during long-running events |
| `READ_CONTACTS` | Populate the VIP contact bypass list |

---

## CI / CD

| Workflow | Trigger | Output |
|---|---|---|
| **CI** ([ci.yml](.github/workflows/ci.yml)) | Push to `main` / `develop`, PR to `main` | Analyze, test, debug APK (uploaded as artifact) |
| **Release** ([release.yml](.github/workflows/release.yml)) | Push a `v*` tag | APK + AAB attached to a GitHub Release |

---

## Contributing

Contributions are welcome. Please read the guidelines below before opening a PR.

1. **Fork** the repository and create a feature branch from `main`.
2. Follow the existing Clean Architecture structure — new features go through a use-case.
3. Run `flutter analyze` and `flutter test` locally; both must pass.
4. Fill in the [PR template](.github/PULL_REQUEST_TEMPLATE.md) when opening a pull request.
5. For significant changes, open an issue first to discuss the approach.

Bug reports and feature requests go through the [issue tracker](https://github.com/AB69D/contextual-phone-silence/issues) using the provided templates.

---

## Deep Link

The app registers the `contextualsilence://` URI scheme. Notifications use this scheme to deep-link directly into screens such as the Missed Digest.

---

## License

This project is licensed under the [MIT License](LICENSE).
