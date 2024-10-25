// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Models",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Models", targets: ["Models"])
    ],
    dependencies: [
        .package(path: "../Core")
    ],
    targets: [
        .target(name: "Models", dependencies: ["Core"])
    ]
)
