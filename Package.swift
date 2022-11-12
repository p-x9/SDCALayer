// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "JSONCALayer",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "JSONCALayer",
            targets: ["JSONCALayer"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/p-x9/IndirectlyCodable.git", exact: "0.0.1")
    ],
    targets: [
        .target(
            name: "JSONCALayer",
            dependencies: [
                .product(name: "IndirectlyCodable", package: "IndirectlyCodable")
            ]
        ),
        .testTarget(
            name: "JSONCALayerTests",
            dependencies: ["JSONCALayer"]
        ),
    ]
)
