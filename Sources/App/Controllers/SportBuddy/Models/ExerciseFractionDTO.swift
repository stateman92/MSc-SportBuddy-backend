//
// ExerciseFractionDTO.swift
//
// Generated by vapor-server-codegen
// https://github.com/thecheatah/SwiftVapor-swagger-codegen
// Template Input: /Models.ExerciseFractionDTO

import Vapor


public final class ExerciseFractionDTO: Content {

    public var time: ExerciseFractionTimeUnitDTO
    public var motionType: MotionTypeDTO

    public init(time: ExerciseFractionTimeUnitDTO, motionType: MotionTypeDTO) { 
        self.time = time
        self.motionType = motionType
    }
}
