//
//  MotionType.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

enum MotionType: String, Codable, CaseIterable {
    case runningMotion1
    case runningMotion2
    case runningMotion3
}

extension MotionType: Modellable {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    init(from dto: MotionTypeDTO) {
        switch dto {
        case .runningmotion1: self = .runningMotion1
        case .runningmotion2: self = .runningMotion2
        case .runningmotion3: self = .runningMotion3
        }
    }

    /// Get the object as a DTO object.
    var dto: MotionTypeDTO {
        switch self {
        case .runningMotion1: return .runningmotion1
        case .runningMotion2: return .runningmotion2
        case .runningMotion3: return .runningmotion3
        }
    }
}

extension MotionTypeDTO {
    /// Get the DTO object as an object.
    var model: MotionType {
        .init(from: self)
    }
}
