// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChromicPack",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ChromicPack",
            targets: ["ChromicPack"]),
    ],
    dependencies: [
//        .package(url: "https://github.com/JyHu/SwiftExtensions", branch: "main"),
        .package(path: "/Users/hujinyou/Documents/Project/Owner/SwiftExtensions"),
        .package(path: "/Users/hujinyou/Documents/Project/Owner/SwiftUIExtension"),
//        .package(url: "https://github.com/JyHu/SwiftUIExtension", branch: "main"),
        .package(url: "https://github.com/JyHu/SFSymbols", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ChromicPack",
            dependencies: [
                "SwiftExtensions",
                "SwiftUIExtension",
                "SFSymbols"
            ]
        ),

    ]
)
