# Changelog

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
