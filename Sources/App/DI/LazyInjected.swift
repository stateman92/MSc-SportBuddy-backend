//
//  LazyInjected.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

@propertyWrapper struct LazyInjected<Service> {
    private lazy var service: Service = DependencyInjector.resolve()

    var wrappedValue: Service {
        mutating get { service }
        mutating set { service = newValue }
    }

    var projectedValue: Self {
        get { self }
        mutating set { self = newValue }
    }
}
