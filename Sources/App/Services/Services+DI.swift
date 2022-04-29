//
//  Services+DI.swift
//  
//
//  Created by Kristof Kalai on 2022. 04. 29..
//

extension DependencyInjector {
    /// Register all the services of the application.
    static func registerServices() {
        resolver.register { AuthorizationService() }.implements(AuthorizationServiceProtocol.self)
        resolver.register { AuthenticationService() }.implements(AuthenticationServiceProtocol.self)
        resolver
            .register { () -> EmailServiceProtocol in
                if isTesting() {
                    return MockEmailService()
                } else {
                    return EmailService()
                }
            }
        resolver.register { CoderService() }.implements(CoderServiceProtocol.self)
    }
}
