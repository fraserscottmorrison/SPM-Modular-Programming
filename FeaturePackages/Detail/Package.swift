// swift-tools-version:6.2
import PackageDescription
import Foundation

let isDebug = ProcessInfo.processInfo.environment["IS_DEBUG"] != "true"

let package = Package(
    name: "Detail",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "Detail",
            targets: ["Detail"]
        )
    ],
    traits: [
        .trait(name: "DEBUG", description: "Is Debug Build"), .default(enabledTraits: (isDebug ? ["DEBUG"] : []))
    ],
    dependencies: [
        .package(path: "../Tools")
    ],
    targets: [
        .target(
            name: "DetailMocks",
            dependencies: [],
            path: "Sources/Mocks",
            resources: [.process("Responses")]
        ),
        .target(
            name: "DetailConcurrent",
            dependencies: [
                "Tools",
                .targetItem(name: "DetailMocks", condition: .when(traits: ["DEBUG"]))
            ],
            path: "Sources/Concurrent"
        ),
        .target(
            name: "Detail",
            dependencies: ["DetailConcurrent", "Tools"],
            path: "Sources/Main",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "DetailUnitTests",
            dependencies: ["Detail"],
            path: "Tests"
        )
    ]
)
