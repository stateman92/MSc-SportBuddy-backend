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
    init(from dto: MotionTypeDTO) {
        switch dto {
        case .runningmotion1: self = .runningMotion1
        case .runningmotion2: self = .runningMotion2
        case .runningmotion3: self = .runningMotion3
        }
    }

    var dto: MotionTypeDTO {
        switch self {
        case .runningMotion1: return .runningmotion1
        case .runningMotion2: return .runningmotion2
        case .runningMotion3: return .runningmotion3
        }
    }
}

extension MotionTypeDTO {
    var model: MotionType {
        .init(from: self)
    }
}
