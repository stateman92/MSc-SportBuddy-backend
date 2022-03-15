//
//  ExerciseType.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

enum ExerciseType: String, Codable {
    case highjump
    case running
    case stretching
}

extension ExerciseType: Modellable {
    init(from dto: ExerciseTypeDTO) {
        switch dto {
        case .highjump: self = .highjump
        case .running: self = .running
        case .stretching: self = .stretching
        }
    }

    var dto: ExerciseTypeDTO {
        switch self {
        case .highjump: return .highjump
        case .running: return .running
        case .stretching: return .stretching
        }
    }
}

extension ExerciseTypeDTO {
    var model: ExerciseType {
        .init(from: self)
    }
}
