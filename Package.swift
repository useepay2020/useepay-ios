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
            checksum: "f7ad426de01162211f54edb469ea01c74af2c38795b145f03baf0993d7917cca")
    ]
)
