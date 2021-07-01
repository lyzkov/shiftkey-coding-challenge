// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Shifts",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Shifts",
            targets: ["Shifts"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.18.0"),
        .package(path: "../Common")
    ],
    targets: [
        .target(
            name: "Shifts",
            dependencies: [
                "Common",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ],
            path: "./",
            exclude: ["./Package.swift"]
        ),
    ]
)
