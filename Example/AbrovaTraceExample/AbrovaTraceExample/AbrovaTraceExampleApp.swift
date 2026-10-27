import SwiftUI
import AbrovaTrace

@main
struct AbrovaTraceExampleApp: App {

    init() {
        // Initialize AbrovaTrace SDK
        // Optional launch values (Xcode scheme → Arguments → Environment, or `simctl launch`):
        // ABROVA_TRACE_API_KEY and ABROVA_TRACE_API_URL (another Trace server, for example one you run yourself).
        let env = ProcessInfo.processInfo.environment
        var builder = AbrovaTraceConfigBuilder(apiKey: env["ABROVA_TRACE_API_KEY"] ?? "ab_live_your_api_key")
        if let url = env["ABROVA_TRACE_API_URL"], !url.isEmpty { builder = builder.apiUrl(url) }
        let config = builder
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
