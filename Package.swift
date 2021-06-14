// swift-tools-version:5.3.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Package",
  platforms: [
    .macOS(.v11),
    .iOS(.v14),
  ],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "CalculatorFeature", targets: ["CalculatorFeature"]),
    .library(name: "MultiCalculatorFeature", targets: ["MultiCalculatorFeature"]),
    .library(name: "SettingFeature", targets: ["SettingFeature"]),

    .library(name: "Calculator", targets: ["Calculator"]),
    .library(name: "SnapshotTestHelper", targets: ["SnapshotTestHelper"]),
    .library(name: "Build", targets: ["Build"]),
    .library(name: "Styleguide", targets: ["Styleguide"]),
    .library(name: "DeviceStateModifier", targets: ["DeviceStateModifier"]),
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture.git", .branch("iso")),
    .package(
      name: "SnapshotTesting", url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
      .exact("1.8.2")),
  ],
  targets: [
    .target(
      name: "AppFeature",
      dependencies: [
        "MultiCalculatorFeature",
        "SettingFeature",
        "DeviceStateModifier",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .target(
      name: "CalculatorFeature",
      dependencies: [
        "Calculator",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .testTarget(
      name: "CalculatorFeatureTests",
      dependencies: [
        "CalculatorFeature",
        "SnapshotTestHelper",
        "DeviceStateModifier",
        .product(name: "SnapshotTesting", package: "SnapshotTesting"),
      ],
      exclude: [
        "__Snapshots__"
      ]
    ),
    .target(
      name: "MultiCalculatorFeature",
      dependencies: [
        "CalculatorFeature",
        "DeviceStateModifier",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .target(name: "Calculator"),
    .testTarget(
      name: "CalculatorTests",
      dependencies: [
        "Calculator"
      ]
    ),
    .target(
      name: "SettingFeature",
      dependencies: [
        "Build",
        "Styleguide",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .target(
      name: "SnapshotTestHelper",
      dependencies: [
        .product(name: "SnapshotTesting", package: "SnapshotTesting")
      ]
    ),
    .target(name: "Build"),
    .target(name: "Styleguide"),
    .target(name: "DeviceStateModifier"),
  ]
)
