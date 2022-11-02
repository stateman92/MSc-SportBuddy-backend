//
//  ExerciseError.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Foundation

struct ExerciseError: Codable {
    let id: UUID
    let characteristics: Characteristics
    let error: String
}
