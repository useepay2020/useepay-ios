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
            checksum: "436cdd213755ba94813eef461a5f011574bb8fbc45bee84592012b9673c76ce4")
    ]
)
