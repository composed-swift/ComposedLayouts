// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ComposedLayouts",
    platforms: [
        .iOS(.v11)

    ],
    products: [
        .library(
            name: "ComposedLayouts",
            targets: ["ComposedLayouts"]),
    ],
    dependencies: [
        .package(url: "https://github.com/composed-swift/ComposedUI", from: "0.0.0"),
    ],
    targets: [
        .target(
            name: "ComposedLayouts",
            dependencies: ["ComposedUI"]),
    ]
)
