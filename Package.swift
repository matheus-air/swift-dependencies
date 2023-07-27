// swift-tools-version: 5.6

import PackageDescription

let package = Package(
  name: "swift-dependencies",
  platforms: [
    .iOS(.v11),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
      name: "Dependencies",
      targets: ["Dependencies"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/google/swift-benchmark", from: "0.1.0"),
    .package(url: "git@github.com:matheus-air/combine-schedulers", branch: "ios-11-compatibility"),
    .package(url: "https://github.com/pointfreeco/swift-clocks", from: "0.4.0"),
    .package(url: "git@github.com:matheus-air/swift-concurrency-extras", branch: "ios-11-compatibility"),
    .package(url: "git@github.com:matheus-air/xctest-dynamic-overlay", branch: "ios-11-compatibility"),
  ],
  targets: [
    .target(
      name: "Dependencies",
      dependencies: [
        .product(name: "Clocks", package: "swift-clocks"),
        .product(name: "CombineSchedulers", package: "combine-schedulers"),
        .product(name: "ConcurrencyExtras", package: "swift-concurrency-extras"),
        .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
      ]
    ),
    .testTarget(
      name: "DependenciesTests",
      dependencies: [
        "Dependencies"
      ]
    ),
    .executableTarget(
      name: "swift-dependencies-benchmark",
      dependencies: [
        "Dependencies",
        .product(name: "Benchmark", package: "swift-benchmark"),
      ]
    ),
  ]
)

#if !os(Windows)
  // Add the documentation compiler plugin if possible
  package.dependencies.append(
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  )
#endif

//for target in package.targets {
//  target.swiftSettings = target.swiftSettings ?? []
//  target.swiftSettings?.append(
//    .unsafeFlags([
//      "-Xfrontend", "-warn-concurrency",
//      "-Xfrontend", "-enable-actor-data-race-checks",
//      "-enable-library-evolution",
//    ])
//  )
//}
