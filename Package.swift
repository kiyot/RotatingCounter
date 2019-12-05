// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RotatingCounter",
    platforms: [.iOS(.v10)],
    products: [.library(name: "RotatingCounter", targets: ["RotatingCounter"])],
    targets: [.target(name: "RotatingCounter", path: "RotatingCounter")]
)
