# Abrova Trace for iOS

Error tracking, crash reporting, logging and performance monitoring for iOS apps, reported to your Abrova Trace project.

## Requirements

- iOS 12.0 or later (macOS 10.14+ is also supported; tvOS 12+ through Swift Package Manager)
- Xcode 15.3 or later (Swift 5.10)

## Install

### Swift Package Manager

In Xcode, choose **File > Add Package Dependencies**, enter `https://github.com/Abrova-co/abrova-trace-ios-sdk.git` and select version `0.2.4` or later. In a `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/Abrova-co/abrova-trace-ios-sdk.git", from: "0.2.4")
]
```

### CocoaPods

```ruby
pod 'AbrovaTrace', :git => 'https://github.com/Abrova-co/abrova-trace-ios-sdk.git', :tag => '0.2.4'
```

## Quick start

Initialise the SDK once when the app starts. Get the API key from the Abrova console.

```swift
import SwiftUI
import AbrovaTrace

@main
struct MyApp: App {
    init() {
        AbrovaTrace.shared.initialize(apiKey: "ab_live_your_api_key")
    }

    var body: some Scene {
        WindowGroup { ContentView() }
    }
}
```

In a UIKit app, make the same call in `application(_:didFinishLaunchingWithOptions:)`. Crashes and hangs are now reported.

## What is captured automatically

- Native crashes (signals and Mach exceptions), reported on the next app launch
- Uncaught `NSException`s
- Hangs (main thread blocked for 5 seconds by default)
- Breadcrumbs for app foreground/background
- Device model, OS version and app version with every report

## Usage

Capture a handled error or a message:

```swift
do {
    try submitOrder()
} catch {
    AbrovaTrace.shared.captureError(error, extra: ["order_id": "1234"], tags: ["feature": "checkout"])
}

AbrovaTrace.shared.captureMessage("Payment retried", level: .warning)
```

Set the user, tags and extra data. They are attached to every later report:

```swift
AbrovaTrace.shared.setUserId("user-123")   // pass nil on logout
AbrovaTrace.shared.setTag("plan", value: "pro")
AbrovaTrace.shared.setExtra("cart_items", value: 3)
```

Add a breadcrumb. The most recent breadcrumbs are sent with each error:

```swift
AbrovaTrace.shared.addBreadcrumb("Opened checkout", type: .user, data: ["cart_items": 3])
AbrovaTrace.shared.addNavigationBreadcrumb(from: "Cart", to: "Checkout")
```

Send logs. Logs are batched and sent in the background:

```swift
AbrovaTrace.shared.enableLogging(sourceId: "ios-app", sourceName: "iOS App") // optional
AbrovaTrace.shared.info("Checkout started", metadata: ["cart_items": 3])
AbrovaTrace.shared.warn("Slow response")
AbrovaTrace.shared.logErrorMessage("Payment declined")
```

Also available: `trace`, `logDebugMessage`, `fatal`, and `flushLogs()` to send buffered logs immediately.

Trace HTTP calls (each request is timed and added as a breadcrumb), and time your own operations:

```swift
// Requests made with URLSession.shared
AbrovaTrace.shared.enablePerformanceTracking()

// A session you create yourself
let session = URLSession(configuration: AbrovaTrace.shared.performanceSessionConfiguration())

let items = try PerformanceTracker.track("parse_feed") { try decode(data) }
```

## Configuration

Pass an `AbrovaTraceConfig` instead of the plain key to change the defaults:

```swift
let config = AbrovaTraceConfig(
    apiKey: "ab_live_your_api_key",
    environment: "staging",
    release: "1.4.0",
    debug: true
)
AbrovaTrace.shared.initialize(config: config)
```

| Option | Default | Description |
|--------|---------|-------------|
| `environment` | `"production"` | Environment name shown with each report |
| `release` | app version | Release version of your app |
| `debug` | `false` | Print SDK debug output to the console |
| `enabled` | `true` | Set to `false` to turn the SDK off |
| `captureUncaughtExceptions` | `true` | Report uncaught `NSException`s |
| `captureSignalCrashes` | `true` | Report native crashes |
| `captureAnr` | `true` | Report hangs |
| `anrTimeoutMs` | `5000` | Main-thread block time, in milliseconds, that counts as a hang |
| `maxBreadcrumbs` | `20` | Number of breadcrumbs kept |
| `sampleRate` | `1.0` | Fraction of `captureError` calls that are sent (0.0 to 1.0) |

## License

MIT. See [LICENSE](LICENSE) and [THIRD_PARTY_NOTICES.txt](THIRD_PARTY_NOTICES.txt).
