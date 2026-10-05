import SwiftUI
import AbrovaTrace

@main
struct AbrovaTraceExampleApp: App {

    init() {
        // Initialize AbrovaTrace SDK
        let config = AbrovaTraceConfigBuilder(apiKey: "ab_live_your_api_key")
            .environment("development")
            .release(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)
            .debug(true)
            .captureUncaughtExceptions(true)
            .captureAnr(true)
            .anrTimeoutMs(5000)
            .maxBreadcrumbs(30)
            .sampleRate(1.0)
            .enableOfflineStorage(true)
            .build()

        AbrovaTrace.shared.initialize(config: config)

        // Enable logging
        AbrovaTrace.shared.enableLogging(
            sourceId: "ios-demo-app",
            sourceName: "iOS Demo App"
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
