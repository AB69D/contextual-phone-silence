# Contextual Silence

A Flutter (Android) app that automatically silences your phone based on calendar events — so you never forget to mute before a meeting again.

---

## Features

### Calendar-Aware Auto-Silence
Reads your Google / device calendar and silences the phone automatically before each matched event. A configurable lead-time lets the phone go quiet a few minutes before the event actually starts.

### Keyword Tier Matching
Every calendar event title is scanned against a keyword list. Each keyword maps to one of three tiers:

| Tier | Behaviour |
|------|-----------|
| **Full Silent** | Phone set to silent mode (DND) |
| **Vibrate** | Phone set to vibrate only |
| **Skip** | Event is ignored, phone left unchanged |

Keywords and tiers can be enabled/disabled individually without deleting them.

### Silence Profiles
Named profiles (e.g., *Work*, *Gym*, *Personal*) let you group behaviour and keyword overrides together. One profile is active at a time; switching profiles changes which keyword rules apply.

### VIP Contacts (Bypass List)
Add contacts to a VIP list. Calls from VIP contacts ring through even when the phone is silenced — useful for family or on-call colleagues.

### Missed Digest
After a silence session ends, a notification summarises missed calls and messages so you can catch up instantly. The digest can be enabled or disabled in Settings.

### Manual Silence
A "Silence now" button on the home screen lets you start a silence session immediately without a calendar event — useful for ad-hoc meetings or focus time.

### Auto-Restore
When the matched calendar event ends, the app restores the previous ringer mode automatically. No need to remember to un-mute.

### Custom Schedules
Create schedule rules that combine a calendar source, a keyword filter, and a target profile. Multiple schedules can coexist so, for example, your work calendar silences fully while your personal calendar only vibrates.

### Session History
Every silence session (automatic or manual) is logged with:
- Start / end time and duration
- Event title that triggered it
- Number of missed calls during the session
- Whether it was automatic or manual

Aggregate stats (total sessions, total hours protected, total calls blocked) are shown in a header bar.

### Boot-Resilient Scheduling
Exact alarms are rescheduled automatically after a device reboot, app update, or quick-boot so no meeting is missed even after a restart.

### Battery Optimisation Handling
The app detects and navigates to the battery optimisation exemption screen for all major OEMs (Samsung, Xiaomi / MIUI, Huawei, ColorOS, OnePlus) so background scheduling keeps working reliably.

### Permission Health Check
The Settings screen shows the live status of three critical permissions and surfaces a shortcut to fix any that are missing:

- Do Not Disturb access
- Exact alarm scheduling
- Battery optimisation exclusion

---

## Architecture

The project follows **Clean Architecture** with three layers:

```
lib/
├── core/          # DI (GetIt), constants, error types, utilities
├── data/          # Drift SQLite database, repositories, data-sources
│   ├── database/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/        # Entities, repository interfaces, use-cases
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/  # Screens, view-models (MVVM + Provider), theme, router
    ├── router/    # go_router
    ├── screens/
    ├── theme/
    └── widgets/
```

**State management:** Provider + ViewModel  
**Local DB:** Drift (SQLite)  
**Dependency injection:** GetIt  
**Navigation:** go_router  
**Platform integration:** Flutter MethodChannels for calendar, audio, alarms, and permissions

Android-side native code lives in `android/app/src/main/kotlin/` and includes:
- `AlarmScheduler` — schedules / cancels exact alarms
- `SilenceAlarmReceiver` — BroadcastReceiver that fires at event start/end
- `AudioStateManager` — reads and sets the ringer mode
- `CalendarSyncWorker` — WorkManager periodic sync (every 15 min)
- `BootReceiver` — reschedules alarms after reboot
- `OemBatteryHelper` — OEM-specific battery optimisation intents

---

## Permissions Required

| Permission | Purpose |
|---|---|
| `READ_CALENDAR` | Read calendar events |
| `ACCESS_NOTIFICATION_POLICY` | Control Do Not Disturb |
| `SCHEDULE_EXACT_ALARM` / `USE_EXACT_ALARM` | Precise alarm timing |
| `RECEIVE_BOOT_COMPLETED` | Reschedule after reboot |
| `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` | Reliable background operation |
| `FOREGROUND_SERVICE` | Keep service alive during long events |
| `READ_CONTACTS` | VIP contact bypass list |

---

## Tech Stack

| Layer | Library |
|---|---|
| UI | Flutter + Material 3 |
| State | Provider 6 |
| Navigation | go_router 13 |
| Database | Drift 2 (SQLite) |
| DI | GetIt 7 |
| Background | WorkManager 0.5 + flutter_foreground_task |
| Notifications | flutter_local_notifications |
| Preferences | shared_preferences |
| Contacts | flutter_contacts |
| Code gen | build_runner, freezed, json_serializable |

---

## Getting Started

### Prerequisites
- Flutter >= 3.22
- Dart >= 3.4
- Android SDK (target API 34+)

### Setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

On first launch the onboarding flow will guide you through granting the required permissions.

---

## Deep Link

The app registers the `contextualsilence://` URI scheme. Notifications use this scheme to deep-link directly into the Missed Digest screen.
