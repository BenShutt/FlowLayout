// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlowLayout",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "FlowLayout",
            targets: ["FlowLayout"]
        )
    ],
    targets: [
        .target(
            name: "FlowLayout",
            path: "Sources"
        ),
        .testTarget(
            name: "FlowLayoutTests",
            dependencies: ["FlowLayout"],
            path: "Tests"
        )
    ]
)
