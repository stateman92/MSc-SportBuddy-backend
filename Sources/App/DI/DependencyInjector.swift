//
//  DependencyInjector.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Resolver
import Vapor
import Gatekeeper

/// A thin layer between the application and the DI library (Resolver).
public struct DependencyInjector {
    private static let resolver = Resolver()
}

extension DependencyInjector {
    /// Register all the dependencies of the application.
    public static func registerDependencies() {
        setupDefaultScope()

        registerControllers()
        registerServices()
        registerMiddlewares()
        registerMigrations()
    }

    /// Resolve a given type of dependency.
    public static func resolve<Service>() -> Service {
        resolver.resolve()
    }
}

extension DependencyInjector {
    /// Setup the default scope of the registrations.
    private static func setupDefaultScope() {
        Resolver.defaultScope = Resolver.shared
    }
}

extension DependencyInjector {
    /// Register all the controllers of the application.
    private static func registerControllers() {
        resolver.register { SportBuddyController() }

        resolver.register(ChatControllerProtocol.self) { ChatController() }
        resolver.register(ChatEntriesControllerProtocol.self) { ChatEntriesController() }
        resolver.register(ExerciseControllerProtocol.self) { ExerciseController() }
        resolver.register(GroupControllerProtocol.self) { GroupController() }
        resolver.register(GroupEntriesControllerProtocol.self) { GroupEntriesController() }
        resolver.register(GroupManagingControllerProtocol.self) { GroupManagingController() }
        resolver.register(SearchControllerProtocol.self) { SearchController() }
        resolver.register(UserControllerProtocol.self) { UserController() }
    }

    /// Register all the services of the application.
    private static func registerServices() {
        resolver.register(AuthorizationServiceProtocol.self) { AuthorizationService() }
        resolver.register(AuthenticationServiceProtocol.self) { AuthenticationService() }
        resolver.register(EmailServiceProtocol.self) { isTesting() ? MockEmailService() as EmailServiceProtocol : EmailService() as EmailServiceProtocol }
    }

    /// Register all the middlewares of the application.
    private static func registerMiddlewares() {
        resolver.register { SecretMiddleware() }
        resolver.register { CORSMiddleware() }
        resolver.register { GatekeeperMiddleware() }
    }

    /// Register all the migrations of the application.
    private static func registerMigrations() {
        resolver.register { InitialMigration() }
    }
}
