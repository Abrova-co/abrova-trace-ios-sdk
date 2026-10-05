# Changelog

## 0.2.4 - 2026-10-06

- A report that is sent again is counted once: every error carries an `event_id` that stays the same on each attempt.

## 0.2.3 - 2026-10-05

- `initialize` no longer waits for the network: the crash report of the previous session is sent in the background.
- A crash report is kept and sent on a later launch when the server or the network fails.
- `enableOfflineStorage` works: errors that cannot be sent while offline are kept (up to 100) and sent later.

## 0.2.1 - 2026-10-05

First public release.

- Native crash reports (signals and Mach exceptions), sent on the next app launch.
- Automatic reporting of uncaught `NSException`s and main-thread hangs.
- `captureError`, `captureException` and `captureMessage` for handled errors and messages, with user ID, tags and extra data.
- Breadcrumbs: automatic for app foreground/background, plus your own.
- Batched logging with six levels, from trace to fatal.
- HTTP request timing and breadcrumbs for `URLSession`.
- Performance spans for your own operations with `PerformanceTracker`.
- Swift Package Manager and CocoaPods support.
