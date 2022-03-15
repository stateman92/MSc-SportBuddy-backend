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
    init(from dto: ExerciseFractionTimeUnitDTO) {
        self.init(fromTime: dto.fromTime, toTime: dto.toTime)
    }

    var dto: ExerciseFractionTimeUnitDTO {
        .init(fromTime: fromTime, toTime: toTime)
    }
}

extension ExerciseFractionTimeUnitDTO {
    var model: ExerciseFractionTimeUnit {
        .init(from: self)
    }
}
