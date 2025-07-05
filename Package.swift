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
            url: "https://github.com/useepay2020/useepay-ios/releases/download/0.0.5/UseePayCore.xcframework.zip",
            checksum: "7a0d9e006632a1c116c9e13883a0675e43f0377273d74f38e9823255a0c1800d")
    ]
)
