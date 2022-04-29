//
//  Exercise.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import FluentPostgresDriver
import Foundation

final class Exercise {
    @ID(key: .id) var id: UUID?
    @Field(key: "exerciseType") var exerciseType: ExerciseType
    @Field(key: "previewImage") var previewImage: String
    @Field(key: "exerciseVideoUrl") var exerciseVideoUrl: String
    @Field(key: "fractions") var fractions: [ExerciseFraction]
    @Timestamp(key: "createdAt", on: .create, format: .iso8601) var createdAt: Date?
    @Timestamp(key: "updatedAt", on: .update, format: .iso8601) var updatedAt: Date?

    /// Initialize an object.
    /// - Parameter id: the identifier.
    /// - Parameter exerciseType: the type of the exercise
    /// - Parameter previewImage: the preview image of the exercise.
    /// - Parameter exerciseVideoUrl: the video url of the exercise.
    /// - Parameter fractions: the fractions of the exercise.
    init(id: UUID?, exerciseType: ExerciseType, previewImage: String, exerciseVideoUrl: String, fractions: [ExerciseFraction]) {
        self.id = id
        self.exerciseType = exerciseType
        self.previewImage = previewImage
        self.exerciseVideoUrl = exerciseVideoUrl
        self.fractions = fractions
    }
}

extension Exercise: PostgresModellable {
    /// The schema of the class.
    static var schema: String {
        Constants.Schema.exercises.rawValue
    }

    /// Initialize an empty object for a new record in the schema.
    convenience init() {
        self.init(id: .init(), exerciseType: .running, previewImage: .init(), exerciseVideoUrl: .init(), fractions: .init())
    }

    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    convenience init(from dto: ExerciseDTO) {
        self.init(id: dto.primaryId, exerciseType: dto.exerciseType.model, previewImage: dto.previewImage, exerciseVideoUrl: dto.exerciseVideoUrl, fractions: dto.fractions.map(\.model))
    }

    /// Get the object as a DTO object.
    var dto: ExerciseDTO {
        .init(primaryId: id ?? .init(), exerciseType: exerciseType.dto, previewImage: previewImage, exerciseVideoUrl: exerciseVideoUrl, fractions: fractions.map(\.dto))
    }
}

extension ExerciseDTO {
    /// Get the DTO object as an object.
    var model: Exercise {
        .init(from: self)
    }
}
