// swift-tools-version:6.2
import PackageDescription
import Foundation

let isDebug = ProcessInfo.processInfo.environment["IS_RELEASE"] != "true"

let package = Package(
    name: "Entry",
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
            name: "Entry",
            targets: ["Entry"]
        )
    ],
    traits: [
        .trait(name: "DEBUG", description: "Is Debug Build"), .default(enabledTraits: (isDebug ? ["DEBUG"] : []))
    ],
    dependencies: [
        .package(path: "../Detail"),
        .package(path: "../../SharedPackages/Tools")
    ],
    targets: [
        .target(
            name: "EntryMocks",
            dependencies: [],
            path: "Sources/Mocks",
            resources: [.process("Responses")]
        ),
        .target(
            name: "EntryConcurrent",
            dependencies: [
                "Tools",
                .targetItem(name: "EntryMocks", condition: .when(traits: ["DEBUG"]))
            ],
            path: "Sources/Concurrent"
        ),
        .target(
            name: "Entry",
            dependencies: ["EntryConcurrent", "Detail", "Tools"],
            path: "Sources/Main",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "EntryUnitTests",
            dependencies: ["Entry"],
            path: "Tests"
        )
    ]
)
