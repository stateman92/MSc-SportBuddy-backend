//
//  DependencyInjector.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Resolver
import Vapor
import Gatekeeper

public struct DependencyInjector {
    private static let resolver = Resolver()
}

extension DependencyInjector {
    public static func registerDependencies() {
        setupDefaultScope()

        registerControllers()
        registerServices()
        registerMiddlewares()
        registerMigrations()
    }

    public static func resolve<Service>() -> Service {
        resolver.resolve()
    }
}

extension DependencyInjector {
    private static func setupDefaultScope() {
        Resolver.defaultScope = Resolver.shared
    }
}

extension DependencyInjector {
    private static func registerControllers() {
        resolver.register { SportBuddyController() }

        resolver.register(ChatControllerProtocol.self) { ChatController() }
        resolver.register(ExerciseControllerProtocol.self) { ExerciseController() }
        resolver.register(ExerciseControllerProtocol.self) { ExerciseController() }
        resolver.register(UserControllerProtocol.self) { UserController() }
        resolver.register(SearchControllerProtocol.self) { SearchController() }
        resolver.register(GroupManagingControllerProtocol.self) { GroupManagingController() }
    }

    private static func registerServices() {
        resolver.register(AuthorizationServiceProtocol.self) { AuthorizationService() }
        resolver.register(AuthenticationServiceProtocol.self) { AuthenticationService() }
        resolver.register(EmailServiceProtocol.self) { isTesting() ? MockEmailService() as EmailServiceProtocol : EmailService() as EmailServiceProtocol }
    }

    private static func registerMiddlewares() {
        resolver.register { SecretMiddleware() }
        resolver.register { CORSMiddleware() }
        resolver.register { GatekeeperMiddleware() }
    }

    private static func registerMigrations() {
        resolver.register { InitialMigration() }
    }
}
