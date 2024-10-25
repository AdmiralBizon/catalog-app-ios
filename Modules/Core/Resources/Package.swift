// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Resources",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Resources", targets: ["Resources"])
    ],
    targets: [
        .target(name: "Resources")
    ]
)
