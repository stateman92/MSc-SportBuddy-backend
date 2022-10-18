//
//  ExerciseMoment.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Foundation

struct ExerciseMoment: Codable {
    let armCharacteristics: Characteristics
    let legCharacteristics: Characteristics
    let errors: [ExerciseError]
}
