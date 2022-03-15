//
//  Exercise.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver
import Foundation

final class Exercise {
    typealias IDValue = UUID
    
    @ID(key: .id) var id: UUID?
    @Field(key: "exerciseType") var exerciseType: ExerciseType
    @Field(key: "previewImageUrl") var previewImageUrl: String
    @Field(key: "exerciseVideoUrl") var exerciseVideoUrl: String
    @Field(key: "fractions") var fractions: [ExerciseFraction]

    init(id: UUID?, exerciseType: ExerciseType, previewImageUrl: String, exerciseVideoUrl: String, fractions: [ExerciseFraction]) {
        self.id = id
        self.exerciseType = exerciseType
        self.previewImageUrl = previewImageUrl
        self.exerciseVideoUrl = exerciseVideoUrl
        self.fractions = fractions
    }
}

extension Exercise: PostgresModellable {
    static var schema: String {
        Constants.Schema.exercises.rawValue
    }

    convenience init() {
        self.init(id: UUID(), exerciseType: .running, previewImageUrl: .empty, exerciseVideoUrl: .empty, fractions: .empty)
    }

    convenience init(from dto: ExerciseDTO) {
        self.init(id: dto.primaryId, exerciseType: dto.exerciseType.model, previewImageUrl: dto.previewImageUrl, exerciseVideoUrl: dto.exerciseVideoUrl, fractions: dto.fractions.map(\.model))
    }

    var dto: ExerciseDTO {
        .init(primaryId: id ?? UUID(), exerciseType: exerciseType.dto, previewImageUrl: previewImageUrl, exerciseVideoUrl: exerciseVideoUrl, fractions: fractions.map(\.dto))
    }
}

extension ExerciseDTO {
    var model: Exercise {
        .init(from: self)
    }
}
