// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "OneKit",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "OneKit",
            targets: ["OneKit"]
        ),
    ],
    targets: [
        .target(
            name: "OneKit"
        ),
        .testTarget(
            name: "OneKitTests",
            dependencies: ["OneKit"]
        ),
    ]
)
