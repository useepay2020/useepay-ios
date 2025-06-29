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
            url: "https://github.com/useepay2020/useepay-ios/releases/download/0.0.4/UseePayCore.xcframework.zip",
            checksum: "0427e3e9ebfbff30d9dcd5d998a3ef574fe12b453bf01890a61c8578aaff45e0")
    ]
)
