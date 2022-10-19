//
//  ExerciseModel.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Foundation

final class ExerciseModel: Codable {
    enum Keys: String {
        case sequence
        case sequenceCount
        case delay
        case createdAt
        case updatedAt
        case videoId
    }

    @LazyInjected private var coderService: CoderService
    @ID(key: .id) var id: UUID?
    @Field(Keys.sequence) private var _sequence: String
    var sequence: [ExerciseMoment] {
        get {
            coderService.decode(string: _sequence) ?? .init()
        }
        set {
            _sequence = coderService.encode(object: newValue) ?? .init()
        }
    }
    @Field(Keys.sequenceCount) var sequenceCount: Int
    @Field(Keys.delay) var delay: TimeInterval
    @Field(Keys.videoId) var videoId: String
    @Timestamp(Keys.createdAt, on: .create) var createdAt: Date?
    @Timestamp(Keys.updatedAt, on: .update) var updatedAt: Date?

    lazy var states: [ExerciseMoment] = {
        var states = [ExerciseMoment]()
        (0..<sequenceCount).forEach { _ in
            sequence.forEach {
                states.append($0)
            }
        }
        return states
    }()

    /// Initialize an object.
    /// - Parameter id: the identifier.
    /// - Parameter sequence: the exercise moments.
    /// - Parameter sequenceCount: the number of sequences.
    /// - Parameter delay: the delay between the moments.
    /// - Parameter videoId: the youtube id of the video.
    init(id: UUID?, sequence: [ExerciseMoment], sequenceCount: Int, delay: TimeInterval, videoId: String) {
        self.id = id
        self.sequence = sequence
        self.sequenceCount = sequenceCount
        self.delay = delay
        self.videoId = videoId
    }
}

extension ExerciseModel: PostgresModellable {
    /// The schema of the class.
    static var schema: String {
        Constants.Schema.exerciseModels.rawValue
    }

    /// Initialize an empty object for a new record in the schema.
    convenience init() {
        self.init(id: .init(), sequence: .init(), sequenceCount: .zero, delay: .zero, videoId: .init())
    }

    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    convenience init(from dto: ExerciseModelDTO) {
        self.init(
            id: .init(),
            sequence: dto.sequence.map {
                .init(
                    armCharacteristics: .init(from: $0.armCharacteristics),
                    legCharacteristics: .init(from: $0.legCharacteristics),
                    errors: $0.errors.map {
                        .init(characteristics: .init(from: $0.characteristics), error: $0.error)
                    })
            },
            sequenceCount: dto.sequenceCount,
            delay: dto.delay,
            videoId: dto.videoId)
    }

    /// Get the object as a DTO object.
    var dto: ExerciseModelDTO {
        .init(
            id: id ?? .init(),
            sequence: sequence.map {
                .init(
                    armCharacteristics: $0.armCharacteristics.dto,
                    legCharacteristics: $0.legCharacteristics.dto,
                    errors: $0.errors.map {
                        .init(characteristics: $0.characteristics.dto, error: $0.error)
                    })
            },
            sequenceCount: sequenceCount,
            delay: delay,
            videoId: videoId)
    }
}
