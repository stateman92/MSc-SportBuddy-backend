// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "SportBuddy",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", exact: .init(4, 65, 2)),
        .package(url: "https://github.com/vapor/fluent.git", exact: .init(4, 4, 0)),
        .package(url: "https://github.com/vapor/postgres-kit.git", exact: .init(2, 5, 1)),
        .package(url: "https://github.com/vapor/postgres-nio.git", exact: .init(1, 7, 2)),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", exact: .init(2, 2, 4)),
        .package(url: "https://github.com/nodes-vapor/gatekeeper.git", exact: .init(4, 2, 0)),
        .package(url: "https://github.com/vapor-community/sendgrid.git", exact: .init(4, 0, 0)),
        .package(url: "https://github.com/hmlongco/Resolver.git", exact: .init(1, 3, 0)),
        .package(url: "https://github.com/vapor-community/mailgun.git", exact: .init(5, 0, 0))
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
                .product(name: "Resolver", package: "Resolver"),
                .product(name: "Mailgun", package: "mailgun")
            ],
            swiftSettings: [
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .executableTarget(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
