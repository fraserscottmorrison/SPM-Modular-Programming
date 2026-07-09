// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "Entry",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "Entry",
            targets: ["Entry"]
        )
    ],
    dependencies: [
        .package(path: "../Detail"),
        .package(path: "../Tools")
    ],
    targets: [
        .target(
            name: "EntryConcurrent",
            dependencies: ["Tools"],
            path: "Sources/Concurrent"
        ),
        .target(
            name: "Entry",
            dependencies: ["EntryConcurrent", "Detail", "Tools"],
            path: "Sources/Main"
        ),
        .testTarget(
            name: "EntryUnitTests",
            dependencies: ["Entry"],
            path: "Tests"
        )
    ]
)
