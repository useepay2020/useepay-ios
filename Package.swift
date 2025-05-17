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
            url: "https://github.com/useepay2020/useepay-ios/releases/download/0.0.1/UseePayCore.xcframework.zip",
            checksum: "46d186b87f144065f1d67c85eac11193560a23666196b3d2bab6bad2a8944f0a")
    ]
)
