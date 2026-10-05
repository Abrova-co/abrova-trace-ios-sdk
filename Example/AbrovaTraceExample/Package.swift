// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "AbrovaTraceExample",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    dependencies: [
        .package(name: "AbrovaTrace", path: "../.."),
    ],
    targets: [
        .executableTarget(
            name: "AbrovaTraceExample",
            dependencies: ["AbrovaTrace"],
            path: "AbrovaTraceExample"
        ),
    ]
)
