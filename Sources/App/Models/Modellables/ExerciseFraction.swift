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
    init(from dto: ExerciseFractionDTO) {
        self.init(time: dto.time.model, motionType: dto.motionType.model)
    }

    var dto: ExerciseFractionDTO {
        .init(time: time.dto, motionType: motionType.dto)
    }
}

extension ExerciseFractionDTO {
    var model: ExerciseFraction {
        .init(from: self)
    }
}
