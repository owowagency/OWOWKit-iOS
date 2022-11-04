// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "OWOWKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "OWOWKit",
            targets: ["OWOWKit"]
        ),
        .library(
            name: "OWOWDeveloperTools",
            targets: ["OWOWDeveloperTools"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "OWOWKit",
            dependencies: []
        ),
        .target(
            name: "OWOWDeveloperTools",
            dependencies: ["OWOWKit"],
            resources: [
                .process("Assets/Assets.xcassets"),
                .process("Assets/en.lproj")
            ]),
        .testTarget(
            name: "OWOWKitTests",
            dependencies: ["OWOWKit"]
        )
    ]
)
