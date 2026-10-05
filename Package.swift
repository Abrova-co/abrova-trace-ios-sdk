// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AbrovaTrace",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_14),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "AbrovaTrace",
            targets: ["AbrovaTrace"]
        ),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "CrashReporter",
            path: "Frameworks/CrashReporter.xcframework"
        ),
        .target(
            name: "AbrovaTrace",
            dependencies: ["CrashReporter"],
            path: "Sources/AbrovaTrace"
        ),
        .testTarget(
            name: "AbrovaTraceTests",
            dependencies: ["AbrovaTrace"],
            path: "Tests/AbrovaTraceTests"
        ),
    ],
    swiftLanguageVersions: [.v5, .version("6")]
)
