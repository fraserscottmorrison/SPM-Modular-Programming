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
            name: "Entry",
            dependencies: ["Detail", "Tools"],
            path: "Sources/Main"
        ),
        .testTarget(
            name: "EntryUnitTests",
            dependencies: ["Entry"],
            path: "Tests"
        )
    ]
)
