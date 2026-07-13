// swift-tools-version:6.2
import PackageDescription
import Foundation

let isDebug = ProcessInfo.processInfo.environment["IS_RELEASE"] != "true"

let package = Package(
    name: "Tools",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "Tools",
            targets: ["Tools"])
    ],
    traits: [
        .trait(name: "DEBUG", description: "Is Debug Build"), .default(enabledTraits: (isDebug ? ["DEBUG"] : []))
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ToolsMocks",
            dependencies: [],
            path: "Sources/Mocks",
            resources: [.process("Responses")]
        ),
        .target(
            name: "ToolsConcurrent",
            dependencies: [
                .targetItem(name: "ToolsMocks", condition: .when(traits: ["DEBUG"]))
            ],
            path: "Sources/Concurrent"
        ),
        .target(
            name: "Tools",
            dependencies: ["ToolsConcurrent"],
            path: "Sources/Main",
            exclude: [],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "ToolsTests",
            dependencies: ["Tools"],
            path: "Tests"
        )
    ]
)
