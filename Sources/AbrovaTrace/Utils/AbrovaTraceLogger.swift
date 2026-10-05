import Foundation
import os.log

/// Internal logger for AbrovaTrace SDK
public class AbrovaTraceLogger: @unchecked Sendable {
    public static let shared = AbrovaTraceLogger()

    private let subsystem = "ir.abrova.trace.sdk"
    private let category = "AbrovaTrace"

    private var _logger: Any?

    private let legacyLog = OSLog(subsystem: "ir.abrova.trace.sdk", category: "AbrovaTrace")

    public var isDebugEnabled: Bool = false

    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    private var logger: Logger {
        if let existing = _logger as? Logger {
            return existing
        }
        let newLogger = Logger(subsystem: subsystem, category: category)
        _logger = newLogger
        return newLogger
    }

    private init() {}

    public func debug(_ message: String) {
        guard isDebugEnabled else { return }

        if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
            logger.debug("[\(self.category)] \(message)")
        } else {
            os_log("[%{public}@] %{public}@", log: legacyLog, type: .debug, category, message)
        }
    }

    public func info(_ message: String) {
        guard isDebugEnabled else { return }

        if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
            logger.info("[\(self.category)] \(message)")
        } else {
            os_log("[%{public}@] %{public}@", log: legacyLog, type: .info, category, message)
        }
    }

    public func warn(_ message: String) {
        if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
            logger.warning("[\(self.category)] \(message)")
        } else {
            os_log("[%{public}@] %{public}@", log: legacyLog, type: .default, category, message)
        }
    }

    public func error(_ message: String) {
        if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
            logger.error("[\(self.category)] \(message)")
        } else {
            os_log("[%{public}@] %{public}@", log: legacyLog, type: .error, category, message)
        }
    }
}

// Convenience global functions
internal func logDebug(_ message: String) {
    AbrovaTraceLogger.shared.debug(message)
}

internal func logInfo(_ message: String) {
    AbrovaTraceLogger.shared.info(message)
}

internal func logWarn(_ message: String) {
    AbrovaTraceLogger.shared.warn(message)
}

internal func logError(_ message: String) {
    AbrovaTraceLogger.shared.error(message)
}
