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
        self.init(firstHalfPositionType: dto.firstHalfPositionType.map(HalfPositionType.init(from:)),
                  firstFullPositionType: dto.firstFullPositionType.map(FullPositionType.init(from:)),
                  secondFullPositionType: dto.secondFullPositionType.map(FullPositionType.init(from:)),
                  secondHalfPositionType: dto.secondHalfPositionType.map(HalfPositionType.init(from:)),
                  distanceType: dto.distanceType.map(DistanceType.init(from:)),
                  type: .init(from: dto.type))
    }

    /// Get the object as a DTO object.
    var dto: CharacteristicsDTO {
        .init(firstHalfPositionType: firstHalfPositionType?.dto,
              firstFullPositionType: firstFullPositionType?.dto,
              secondFullPositionType: secondFullPositionType?.dto,
              secondHalfPositionType: secondHalfPositionType?.dto,
              distanceType: distanceType?.dto,
              type: type.dto)
    }
}
