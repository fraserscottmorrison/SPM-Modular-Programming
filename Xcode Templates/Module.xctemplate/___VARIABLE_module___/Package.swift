// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "___VARIABLE_module___",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "___VARIABLE_module___",
            targets: ["___VARIABLE_module___"]
        )
    ],
    dependencies: [
        .package(path: "../Tools")
    ],
    targets: [
        .target(
            name: "___VARIABLE_module___",
            dependencies: ["Tools"],
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
