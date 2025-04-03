// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "ImageViewer_swift",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ImageViewer_swift",
            targets: ["ImageViewer_swift"])
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "8.3.0")),
    ],
    targets: [
        .target(
            name: "ImageViewer_swift",
            dependencies: ["Kingfisher"],
            path: "Sources/ImageViewer_swift")
    ]
)

