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
    ],
    targets: [
        .target(
            name: "JSONCALayer",
            dependencies: []
        ),
        .testTarget(
            name: "JSONCALayerTests",
            dependencies: ["JSONCALayer"]
        ),
    ]
)
