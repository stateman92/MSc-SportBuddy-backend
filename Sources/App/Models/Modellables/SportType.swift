//
//  SportType.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

enum SportType: String, Codable, CaseIterable {
    case athletics
    case yoga
    case workout
}

extension SportType: Modellable {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    init(from dto: SportTypeDTO) {
        switch dto {
        case .athletics: self = .athletics
        case .yoga: self = .yoga
        case .workout: self = .workout
        }
    }

    /// Get the object as a DTO object.
    var dto: SportTypeDTO {
        switch self {
        case .athletics: return .athletics
        case .yoga: return .yoga
        case .workout: return .workout
        }
    }
}

extension SportTypeDTO {
    /// Get the DTO object as an object.
    var model: SportType {
        .init(from: self)
    }
}
