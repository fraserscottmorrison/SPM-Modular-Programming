// swift-tools-version:6.2
import PackageDescription
import Foundation

let isDebug = ProcessInfo.processInfo.environment["IS_RELEASE"] != "true"

let package = Package(
    name: "___VARIABLE_module___",
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
            name: "___VARIABLE_module___",
            targets: ["___VARIABLE_module___"]
        )
    ],
    traits: [
        .trait(name: "DEBUG", description: "Is Debug Build"), .default(enabledTraits: (isDebug ? ["DEBUG"] : []))
    ],
    dependencies: [
        .package(path: "../../SharedPackages/Tools")
    ],
    targets: [
        .target(
            name: "___VARIABLE_module___Mocks",
            dependencies: [],
            path: "Sources/Mocks",
            resources: [.process("Responses")]
        ),
        .target(
            name: "___VARIABLE_module___Concurrent",
            dependencies: [
                "Tools",
                .targetItem(name: "___VARIABLE_module___Mocks", condition: .when(traits: ["DEBUG"]))
            ],
            path: "Sources/Concurrent"
        ),
        .target(
            name: "___VARIABLE_module___",
            dependencies: ["___VARIABLE_module___Concurrent", "Tools"],
            path: "Sources/Main",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "___VARIABLE_module___UnitTests",
            dependencies: ["___VARIABLE_module___"],
            path: "Tests"
        )
    ]
)
