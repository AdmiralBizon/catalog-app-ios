// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Catalog",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Catalog", targets: ["Catalog"])
    ],
    dependencies: [
        .package(path: "../../Core/Core"),
        .package(path: "../../Core/Models"),
        .package(path: "../../Core/Resources"),
        .package(path: "../../Library"),
        .package(path: "../../Services"),
    ],
    targets: [
        .target(
            name: "Catalog",
            dependencies: [
                "Core",
                "Library",
                "Models",
                "Resources",
                "Services"
            ]
        )
    ]
)
