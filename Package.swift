// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SDCALayer",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SDCALayer",
            targets: ["SDCALayer"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/p-x9/IndirectlyCodable.git", exact: "0.0.1"),
        .package(url: "https://github.com/p-x9/KeyPathValue.git", exact: "0.0.1")
    ],
    targets: [
        .target(
            name: "SDCALayer",
            dependencies: [
                .product(name: "IndirectlyCodable", package: "IndirectlyCodable"),
                .product(name: "KeyPathValue", package: "KeyPathValue")
            ]
        ),
        .testTarget(
            name: "SDCALayerTests",
            dependencies: ["SDCALayer"]
        ),
    ]
)
