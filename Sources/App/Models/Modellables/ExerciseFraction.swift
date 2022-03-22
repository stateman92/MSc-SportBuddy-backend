//
//  ExerciseFraction.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

struct ExerciseFraction: Codable {
    let time: ExerciseFractionTimeUnit
    let motionType: MotionType
}

extension ExerciseFraction: Modellable {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    init(from dto: ExerciseFractionDTO) {
        self.init(time: dto.time.model, motionType: dto.motionType.model)
    }

    /// Get the object as a DTO object.
    var dto: ExerciseFractionDTO {
        .init(time: time.dto, motionType: motionType.dto)
    }
}

extension ExerciseFractionDTO {
    /// Get the DTO object as an object.
    var model: ExerciseFraction {
        .init(from: self)
    }
}
