//
//  ExerciseFractionTimeUnit.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

struct ExerciseFractionTimeUnit: Codable {
    let fromTime: Int
    let toTime: Int
}

extension ExerciseFractionTimeUnit: Modellable {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    init(from dto: ExerciseFractionTimeUnitDTO) {
        self.init(fromTime: dto.fromTime, toTime: dto.toTime)
    }

    /// Get the object as a DTO object.
    var dto: ExerciseFractionTimeUnitDTO {
        .init(fromTime: fromTime, toTime: toTime)
    }
}

extension ExerciseFractionTimeUnitDTO {
    /// Get the DTO object as an object.
    var model: ExerciseFractionTimeUnit {
        .init(from: self)
    }
}
