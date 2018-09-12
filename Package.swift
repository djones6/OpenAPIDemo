// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "OpenAPIDemo",
    dependencies: [
      .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "2.5.0"),
      .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.7.1"),
      .package(url: "https://github.com/IBM-Swift/CloudEnvironment.git", from: "8.0.0"),
      .package(url: "https://github.com/RuntimeTools/SwiftMetrics.git", from: "2.0.0"),
      .package(url: "https://github.com/IBM-Swift/Health.git", from: "1.0.0"),
      .package(url: "https://github.com/IBM-Swift/Kitura-OpenAPI.git", from: "1.0.0"),
      .package(url: "https://github.com/IBM-Swift/Swift-Kuery-ORM", from: "0.3.1"),
      .package(url: "https://github.com/IBM-Swift/Swift-Kuery-PostgreSQL", from: "1.2.0"),
      ],
    targets: [
      .target(name: "OpenAPIDemo", dependencies: [ .target(name: "Application"), "Kitura" , "HeliumLogger"]),
      .target(name: "Application", dependencies: [ "Kitura", "CloudEnvironment","SwiftMetrics","Health", "KituraOpenAPI", "SwiftKueryORM", "SwiftKueryPostgreSQL"   ]),

      .testTarget(name: "ApplicationTests" , dependencies: [.target(name: "Application"), "Kitura","HeliumLogger" ])
    ]
)
