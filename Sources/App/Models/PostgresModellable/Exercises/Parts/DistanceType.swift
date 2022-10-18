//
//  DistanceType.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Foundation

enum DistanceType: String, Codable {
    case around0
    case around1
    case around2
    case around3
    case around4
    case aroundMinus1
    case aroundMinus2
    case aroundMinus3
    case aroundMinus4
}

extension DistanceType: Modellable {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    init(from dto: DistanceTypeDTO) {
        switch dto {
        case .around0: self = .around0
        case .around1: self = .around1
        case .around2: self = .around2
        case .around3: self = .around3
        case .around4: self = .around4
        case .aroundminus1: self = .aroundMinus1
        case .aroundminus2: self = .aroundMinus2
        case .aroundminus3: self = .aroundMinus3
        case .aroundminus4: self = .aroundMinus4
        }
    }

    /// Get the object as a DTO object.
    var dto: DistanceTypeDTO {
        switch self {
        case .around0: return .around0
        case .around1: return .around1
        case .around2: return .around2
        case .around3: return .around3
        case .around4: return .around4
        case .aroundMinus1: return .aroundminus1
        case .aroundMinus2: return .aroundminus2
        case .aroundMinus3: return .aroundminus3
        case .aroundMinus4: return .aroundminus4
        }
    }
}
