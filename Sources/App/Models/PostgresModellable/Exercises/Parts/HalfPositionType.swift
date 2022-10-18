//
//  HalfPositionType.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Foundation

enum HalfPositionType: String, Codable {
    case around0
    case around45
    case around90
    case around135
    case around180
}

extension HalfPositionType: Modellable {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    init(from dto: HalfPositionTypeDTO) {
        switch dto {
        case .around0: self = .around0
        case .around45: self = .around45
        case .around90: self = .around90
        case .around135: self = .around135
        case .around180: self = .around180
        }
    }

    /// Get the object as a DTO object.
    var dto: HalfPositionTypeDTO {
        switch self {
        case .around0: return .around0
        case .around45: return .around45
        case .around90: return .around90
        case .around135: return .around135
        case .around180: return .around180
        }
    }
}
