// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Services",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Services", targets: ["Services"])
    ],
    dependencies: [
        .package(path: "../Core/Core"),
        .package(path: "../NetworkLayer")
    ],
    targets: [
        .target(name: "Services", dependencies: ["Core", "NetworkLayer"])
    ]
)
