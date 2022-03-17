// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SportBuddy",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", .exact("4.55.3")),
        .package(url: "https://github.com/vapor/fluent.git", .exact("4.4.0")),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", .exact("2.2.4")),
        .package(url: "https://github.com/nodes-vapor/gatekeeper.git", .exact("4.2.0")),
        .package(url: "https://github.com/vapor-community/sendgrid.git", .exact("4.0.0")),
        .package(url: "https://github.com/hmlongco/Resolver.git", .exact("1.3.0"))
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "Gatekeeper", package: "gatekeeper"),
                .product(name: "SendGrid", package: "sendgrid"),
                .product(name: "Resolver", package: "Resolver")
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides/blob/main/docs/building.md#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .target(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
