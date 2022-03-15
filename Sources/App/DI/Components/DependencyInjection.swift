//
//  DependencyInjection.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//


final class DependencyInjection {
    static let shared = DependencyInjection()
    private init() { }

    private var initables: [DependencyKey: Initable.Type] = [:]
    private var dependecies: [DependencyKey: Any] = [:]
}

extension DependencyInjection {
    func register<T>(_ type: T.Type, name: String? = nil, service: T.Type) where T: Initable {
        initables[DependencyKey(type: type, name: name)] = service
    }

    func register<T>(_ type: T.Type, name: String? = nil, service: () -> T) {
        dependecies[DependencyKey(type: type, name: name)] = service()
    }

    func register<T>(name: String? = nil, service: () -> T) {
        dependecies[DependencyKey(type: T.self, name: name)] = service()
    }

    func resolve<T>(name: String? = nil) -> T {
        initables[DependencyKey(type: T.self, name: name)]?.init() as? T
        ?? dependecies[DependencyKey(type: T.self, name: name)] as! T
    }
}
