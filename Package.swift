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
        .package(url: "https://github.com/p-x9/IndirectlyCodable.git", .upToNextMinor(from: "0.0.1")),
        .package(url: "https://github.com/p-x9/KeyPathValue.git", .upToNextMinor(from: "0.0.1")),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.1")
    ],
    targets: [
        .target(
            name: "SDCALayer",
            dependencies: [
                .product(name: "IndirectlyCodable", package: "IndirectlyCodable"),
                .product(name: "KeyPathValue", package: "KeyPathValue"),
                .product(name: "Yams", package: "Yams")
            ]
        ),
        .testTarget(
            name: "SDCALayerTests",
            dependencies: ["SDCALayer"]
        ),
    ]
)
