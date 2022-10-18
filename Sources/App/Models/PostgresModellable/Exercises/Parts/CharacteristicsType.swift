//
//  CharacteristicsType.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Foundation

enum CharacteristicsType: String, Codable {
    case arms
    case legs
}

extension CharacteristicsType: Modellable {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    init(from dto: CharacteristicsTypeDTO) {
        switch dto {
        case .arms: self = .arms
        case .legs: self = .legs
        }
    }

    /// Get the object as a DTO object.
    var dto: CharacteristicsTypeDTO {
        switch self {
        case .arms: return .arms
        case .legs: return .legs
        }
    }
}
