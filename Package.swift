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
            url: "https://github.com/useepay2020/useepay-ios/releases/download/0.0.2/UseePayCore.xcframework.zip",
            checksum: "4b53255100d64b58d1707077bba2b7496a1e1830141290285147822c9faa2fe5")
    ]
)
