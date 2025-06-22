// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "UseePay",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "UseePayCore",
            targets: ["UseePayCore"])
    ],
    targets: [
        .binaryTarget(
            name: "UseePayCore",
            url: "https://github.com/useepay2020/useepay-ios/releases/download/0.0.3/UseePayCore.xcframework.zip",
            checksum: "744b8dcb18a27ecd8f25636f3faf1cfcee9dfed9819f6b4af6a748eb5a945dcd")
    ]
)
