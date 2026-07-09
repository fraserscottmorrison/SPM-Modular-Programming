// swift-tools-version:6.2
import PackageDescription

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
    dependencies: [
        .package(path: "../Tools")
    ],
    targets: [
        .target(
            name: "DetailConcurrent",
            dependencies: ["Tools"],
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
