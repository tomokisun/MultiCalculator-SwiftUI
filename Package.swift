// swift-tools-version:5.3.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Package",
  platforms: [
    .macOS(.v11),
    .iOS(.v14)
  ],
  products: [
    .library(name: "CalculatorFeature", targets: ["CalculatorFeature"]),
    .library(name: "Calculator", targets: ["Calculator"])
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .branch("iso"))
  ],
  targets: [
    .target(name: "Calculator"),
    .target(
      name: "CalculatorFeature",
      dependencies: [
        "Calculator",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    )
  ]
)
