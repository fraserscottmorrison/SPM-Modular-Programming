// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "Tools",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "Tools",
            targets: ["Tools"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Tools",
            dependencies: [],
            path: "Sources",
            exclude: [],
            resources: []
        ),
        .testTarget(
            name: "ToolsTests",
            dependencies: ["Tools"],
            path: "Tests"
        )
    ]
)
