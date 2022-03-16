//
//  ExerciseControllerProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

protocol ExerciseControllerProtocol {
    func exerciseGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<exerciseGetResponse>
    func exercisePost(with req: Request, asAuthenticated user: User, body: ExerciseDTO) throws -> EventLoopFuture<exercisePostResponse>
    func exercisePut(with req: Request, asAuthenticated user: User, body: ExerciseDTO) throws -> EventLoopFuture<exercisePutResponse>
    func exerciseDelete(with req: Request, asAuthenticated user: User, exerciseId: UUID) throws -> EventLoopFuture<exerciseDeleteResponse>
}
