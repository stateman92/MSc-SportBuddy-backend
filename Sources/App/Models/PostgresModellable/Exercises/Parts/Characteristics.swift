//
//  Characteristics.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Foundation

struct Characteristics: Codable {
    var firstHalfPositionType: HalfPositionType?
    var firstFullPositionType: FullPositionType?
    var secondFullPositionType: FullPositionType?
    var secondHalfPositionType: HalfPositionType?
    var distanceType: DistanceType?

    var type: CharacteristicsType
}

extension Characteristics: Modellable {
    /// Initialize the object from a DTO object.
    /// - Parameter dto: the DTO object.
    init(from dto: CharacteristicsDTO) {
        self.init(firstHalfPositionType: .init(from: dto.firstHalfPositionType),
                  firstFullPositionType: .init(from: dto.firstFullPositionType),
                  secondFullPositionType: .init(from: dto.secondFullPositionType),
                  secondHalfPositionType: .init(from: dto.secondHalfPositionType),
                  distanceType: .init(from: dto.distanceType),
                  type: .init(from: dto.type))
    }

    /// Get the object as a DTO object.
    var dto: CharacteristicsDTO {
        .init(firstHalfPositionType: firstHalfPositionType!.dto,
              firstFullPositionType: firstFullPositionType!.dto,
              secondFullPositionType: secondFullPositionType!.dto,
              secondHalfPositionType: secondHalfPositionType!.dto,
              distanceType: distanceType!.dto,
              type: type.dto)
    }
}
