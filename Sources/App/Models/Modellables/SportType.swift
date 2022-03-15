//
//  SportType.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

enum SportType: String, Codable {
    case athletics
    case yoga
    case workout
}

extension SportType: Modellable {
    init(from dto: SportTypeDTO) {
        switch dto {
        case .athletics: self = .athletics
        case .yoga: self = .yoga
        case .workout: self = .workout
        }
    }

    var dto: SportTypeDTO {
        switch self {
        case .athletics: return .athletics
        case .yoga: return .yoga
        case .workout: return .workout
        }
    }
}

extension SportTypeDTO {
    var model: SportType {
        .init(from: self)
    }
}
