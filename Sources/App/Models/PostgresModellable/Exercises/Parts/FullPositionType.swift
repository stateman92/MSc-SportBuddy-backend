//
//  FullPositionType.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Foundation

enum FullPositionType: String, Codable {
    case around0
    case around45
    case around90
    case around135
    case around180
    case around225
    case around270
    case around315
}

extension FullPositionType: Modellable {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    init(from dto: FullPositionTypeDTO) {
        switch dto {
        case .around0: self = .around0
        case .around45: self = .around45
        case .around90: self = .around90
        case .around135: self = .around135
        case .around180: self = .around180
        case .around225: self = .around225
        case .around270: self = .around270
        case .around315: self = .around315
        }
    }

    /// Get the object as a DTO object.
    var dto: FullPositionTypeDTO {
        switch self {
        case .around0: return .around0
        case .around45: return .around45
        case .around90: return .around90
        case .around135: return .around135
        case .around180: return .around180
        case .around225: return .around225
        case .around270: return .around270
        case .around315: return .around315
        }
    }
}
