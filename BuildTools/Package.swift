// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "BuildTools",
    platforms: [.iOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint", from: "0.38.0"),
    ]
)
