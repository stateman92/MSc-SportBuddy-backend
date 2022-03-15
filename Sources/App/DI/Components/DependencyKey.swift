//
//  DependencyKey.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

final class DependencyKey {
    private let type: Any.Type
    private let name: String?

    init<T>(type: T.Type, name: String? = nil) {
        self.type = type
        self.name = name
    }
}

extension DependencyKey: Equatable {
    static func == (lhs: DependencyKey, rhs: DependencyKey) -> Bool {
        lhs.type == rhs.type && lhs.name == rhs.name
    }
}

extension DependencyKey: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type))
        hasher.combine(name)
    }
}
