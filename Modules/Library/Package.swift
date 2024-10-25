// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Library",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Library", targets: ["Library"])
    ],
    dependencies: [
        .package(path: "../Core/Core"),
        .package(path: "../Core/Resources"),
        .package(path: "../Services")
    ],
    targets: [
        .target(
            name: "Library",
            dependencies: [
                "Core",
                "Resources",
                "Services"
            ]
        )
    ]
)
