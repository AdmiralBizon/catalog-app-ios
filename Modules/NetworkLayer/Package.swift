// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "NetworkLayer",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "NetworkLayer", targets: ["NetworkLayer"])
    ],
    dependencies: [
        .package(path: "../Core/Core"),
        .package(path: "../Core/Models")
    ],
    targets: [
        .target(name: "NetworkLayer", dependencies: ["Core", "Models"])
    ]
)
