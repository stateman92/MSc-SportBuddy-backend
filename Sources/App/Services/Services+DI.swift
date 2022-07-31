//
//  Services+DI.swift
//  
//
//  Created by Kristof Kalai on 2022. 04. 29..
//

extension DependencyInjector {
    /// Register all the services of the application.
    static func registerServices() {
        resolver.register { AuthorizationServiceImpl() }.implements(AuthorizationService.self)
        resolver.register { AuthenticationServiceImpl() }.implements(AuthenticationService.self)
        resolver
            .register { () -> EmailService in
                if isTesting() {
                    return MockEmailService()
                } else {
                    return EmailServiceImpl()
                }
            }
        resolver.register { CoderServiceImpl() }.implements(CoderService.self)
    }
}
