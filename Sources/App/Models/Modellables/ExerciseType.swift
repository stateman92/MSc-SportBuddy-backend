//
//  ExerciseType.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

enum ExerciseType: String, Codable, CaseIterable {
    case highjump
    case running
    case stretching
}

extension ExerciseType: Modellable {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    init(from dto: ExerciseTypeDTO) {
        switch dto {
        case .highjump: self = .highjump
        case .running: self = .running
        case .stretching: self = .stretching
        }
    }

    /// Get the object as a DTO object.
    var dto: ExerciseTypeDTO {
        switch self {
        case .highjump: return .highjump
        case .running: return .running
        case .stretching: return .stretching
        }
    }
}

extension ExerciseTypeDTO {
    /// Get the DTO object as an object.
    var model: ExerciseType {
        .init(from: self)
    }
}
