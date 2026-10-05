import Foundation

/// Configuration for AbrovaTrace SDK
public struct AbrovaTraceConfig {
    /// API Key from Abrova Console (ab_live_xxx)
    public let apiKey: String

    /// Environment name (e.g., "production", "staging", "development")
    public let environment: String

    /// Release/version string of your application.
    /// If nil, auto-detected from CFBundleShortVersionString.
    public let release: String?

    /// Enable debug logging
    public let debug: Bool

    /// Enable/disable the SDK entirely
    public let enabled: Bool

    /// Automatically capture uncaught exceptions
    public let captureUncaughtExceptions: Bool

    /// Capture signal crashes (SIGSEGV, SIGABRT, etc.)
    public let captureSignalCrashes: Bool

    /// Capture ANR (Application Not Responding) events
    public let captureAnr: Bool

    /// ANR detection timeout in milliseconds (default: 5000)
    public let anrTimeoutMs: Int64

    /// Maximum number of breadcrumbs to store
    public let maxBreadcrumbs: Int

    /// HTTP request timeout in seconds
    public let httpTimeout: TimeInterval

    /// Enable offline storage for errors
    public let enableOfflineStorage: Bool

    /// Sample rate for error capture (0.0 to 1.0)
    public let sampleRate: Double

    /// Base URL for the AbrovaTrace API. Override for self-hosted deployments.
    public let apiUrl: String

    /// Initialize with all options
    public init(
        apiKey: String,
        environment: String = "production",
        release: String? = nil,
        debug: Bool = false,
        enabled: Bool = true,
        captureUncaughtExceptions: Bool = true,
        captureSignalCrashes: Bool = true,
        captureAnr: Bool = true,
        anrTimeoutMs: Int64 = 5000,
        maxBreadcrumbs: Int = 20,
        httpTimeout: TimeInterval = 30,
        enableOfflineStorage: Bool = true,
        sampleRate: Double = 1.0,
        apiUrl: String = "https://trace.abrova.ir"
    ) {
        precondition(!apiKey.isEmpty, "API key cannot be empty")
        precondition(apiKey.hasPrefix("ab_live_"), "API key must start with ab_live_")
        precondition(maxBreadcrumbs > 0, "maxBreadcrumbs must be positive")
        precondition(httpTimeout > 0, "httpTimeout must be positive")
        precondition(sampleRate >= 0 && sampleRate <= 1, "sampleRate must be between 0.0 and 1.0")
        precondition(anrTimeoutMs > 0, "anrTimeoutMs must be positive")

        self.apiKey = apiKey
        self.environment = environment
        self.release = release
        self.debug = debug
        self.enabled = enabled
        self.captureUncaughtExceptions = captureUncaughtExceptions
        self.captureSignalCrashes = captureSignalCrashes
        self.captureAnr = captureAnr
        self.anrTimeoutMs = anrTimeoutMs
        self.maxBreadcrumbs = maxBreadcrumbs
        self.httpTimeout = httpTimeout
        self.enableOfflineStorage = enableOfflineStorage
        self.sampleRate = sampleRate
        self.apiUrl = apiUrl
    }

    /// Create a simple config with just API key
    public static func simple(apiKey: String) -> AbrovaTraceConfig {
        return AbrovaTraceConfig(apiKey: apiKey)
    }
}

/// Builder for creating AbrovaTraceConfig
public class AbrovaTraceConfigBuilder {
    private let apiKey: String
    private var environment: String = "production"
    private var release: String?
    private var debug: Bool = false
    private var enabled: Bool = true
    private var captureUncaughtExceptions: Bool = true
    private var captureSignalCrashes: Bool = true
    private var captureAnr: Bool = true
    private var anrTimeoutMs: Int64 = 5000
    private var maxBreadcrumbs: Int = 20
    private var httpTimeout: TimeInterval = 30
    private var enableOfflineStorage: Bool = true
    private var sampleRate: Double = 1.0
    private var apiUrl: String = "https://trace.abrova.ir"

    public init(apiKey: String) {
        self.apiKey = apiKey
    }

    @discardableResult
    public func environment(_ environment: String) -> AbrovaTraceConfigBuilder {
        self.environment = environment
        return self
    }

    @discardableResult
    public func release(_ release: String?) -> AbrovaTraceConfigBuilder {
        self.release = release
        return self
    }

    @discardableResult
    public func debug(_ debug: Bool) -> AbrovaTraceConfigBuilder {
        self.debug = debug
        return self
    }

    @discardableResult
    public func enabled(_ enabled: Bool) -> AbrovaTraceConfigBuilder {
        self.enabled = enabled
        return self
    }

    @discardableResult
    public func captureUncaughtExceptions(_ capture: Bool) -> AbrovaTraceConfigBuilder {
        self.captureUncaughtExceptions = capture
        return self
    }

    @discardableResult
    public func captureSignalCrashes(_ capture: Bool) -> AbrovaTraceConfigBuilder {
        self.captureSignalCrashes = capture
        return self
    }

    @discardableResult
    public func captureAnr(_ capture: Bool) -> AbrovaTraceConfigBuilder {
        self.captureAnr = capture
        return self
    }

    @discardableResult
    public func anrTimeoutMs(_ timeout: Int64) -> AbrovaTraceConfigBuilder {
        self.anrTimeoutMs = timeout
        return self
    }

    @discardableResult
    public func maxBreadcrumbs(_ max: Int) -> AbrovaTraceConfigBuilder {
        self.maxBreadcrumbs = max
        return self
    }

    @discardableResult
    public func httpTimeout(_ timeout: TimeInterval) -> AbrovaTraceConfigBuilder {
        self.httpTimeout = timeout
        return self
    }

    @discardableResult
    public func enableOfflineStorage(_ enable: Bool) -> AbrovaTraceConfigBuilder {
        self.enableOfflineStorage = enable
        return self
    }

    @discardableResult
    public func sampleRate(_ rate: Double) -> AbrovaTraceConfigBuilder {
        self.sampleRate = rate
        return self
    }

    @discardableResult
    public func apiUrl(_ url: String) -> AbrovaTraceConfigBuilder {
        self.apiUrl = url
        return self
    }

    public func build() -> AbrovaTraceConfig {
        return AbrovaTraceConfig(
            apiKey: apiKey,
            environment: environment,
            release: release,
            debug: debug,
            enabled: enabled,
            captureUncaughtExceptions: captureUncaughtExceptions,
            captureSignalCrashes: captureSignalCrashes,
            captureAnr: captureAnr,
            anrTimeoutMs: anrTimeoutMs,
            maxBreadcrumbs: maxBreadcrumbs,
            httpTimeout: httpTimeout,
            enableOfflineStorage: enableOfflineStorage,
            sampleRate: sampleRate,
            apiUrl: apiUrl
        )
    }
}
