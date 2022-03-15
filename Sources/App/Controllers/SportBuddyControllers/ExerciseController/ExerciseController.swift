//
//  ExerciseController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct ExerciseController { }

extension ExerciseController: ExerciseControllerProtocol {
    func exerciseGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<exerciseGetResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }

    func exercisePost(with req: Request, asAuthenticated user: User, body: ExerciseDTO) throws -> EventLoopFuture<exercisePostResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }

    func exercisePut(with req: Request, asAuthenticated user: User, body: ExerciseDTO, exerciseId: UUID) throws -> EventLoopFuture<exercisePutResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }

    func exerciseDelete(with req: Request, asAuthenticated user: User, exerciseId: UUID) throws -> EventLoopFuture<exerciseDeleteResponse> {
        req.eventLoop.makeSucceededFuture(.http400)
    }
}
