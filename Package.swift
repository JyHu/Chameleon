// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Chameleon",
    platforms: [ .macOS(.v10_13), .iOS(.v11) ],
    products: [
        .library(
            name: "Chameleon",
            targets: ["Chameleon"]
        ),
    ],
    targets: [
        .target(
            name: "Chameleon",
            dependencies: []
        ),
        .testTarget(
            name: "ChameleonTests",
            dependencies: ["Chameleon"],
            resources: [.process("Resources")]
        )
    ]
)
