// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "CheckmarkCollectionViewCell",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library( name: "CheckmarkCollectionViewCell", targets: ["CheckmarkCollectionViewCell"])
    ],
    dependencies: [
        .package(url: "https://github.com/yonat/SweeterSwift", from: "1.0.2")
    ],
    targets: [
        .target(name: "CheckmarkCollectionViewCell", dependencies: ["SweeterSwift"], path: "Sources")
    ],
    swiftLanguageVersions: [.v5]
)
