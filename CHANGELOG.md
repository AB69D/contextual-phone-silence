# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] — 2025-06-24

### Added
- Calendar-aware auto-silence: reads device calendar and silences phone before matched events
- Keyword tier matching: map event title keywords to Full Silent, Vibrate, or Skip
- Silence profiles with custom names, icons, colours, and keyword overrides
- VIP contact bypass list — named contacts ring through even during silence
- Missed digest notification — summary of missed calls/messages after each session
- Manual silence via "Silence now" FAB for ad-hoc focus time
- Auto-restore: ringer mode reverts automatically when the event ends
- Custom schedule rules combining a calendar source, keyword filter, and target profile
- Session history with per-session stats and aggregate weekly summary
- Boot-resilient alarm scheduling — exact alarms rescheduled after reboot or app update
- OEM battery optimisation helper for Samsung, Xiaomi, Huawei, ColorOS, and OnePlus
- Permission health-check card in Settings (DND access, exact alarms, battery optimisation)
- Foreground service support for long-running events
- WorkManager periodic calendar sync (every 15 minutes)
- Onboarding flow guiding users through required permissions
- Deep link scheme `contextualsilence://` for notification-driven navigation
- Dark-mode support via Material 3 dynamic theming
- CI pipeline (analyze, test, build debug APK) and release pipeline (APK + AAB → GitHub Release)
