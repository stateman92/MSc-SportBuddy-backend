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
        req
            .eventLoop
            .makeSucceededFuture(.http400)
    }

    func exercisePost(with req: Request, asAuthenticated user: User, body: ExerciseDTO) throws -> EventLoopFuture<exercisePostResponse> {
        body
            .model
            .create(on: req, transformTo: .http200)
    }

    func exercisePut(with req: Request, asAuthenticated user: User, body: ExerciseDTO) throws -> EventLoopFuture<exercisePutResponse> {
        body
            .model
            .update(on: req, transformTo: .http200)
    }

    func exerciseDelete(with req: Request, asAuthenticated user: User, exerciseId: UUID) throws -> EventLoopFuture<exerciseDeleteResponse> {
        Exercise
            .findOrAbort(exerciseId, on: req)
            .flatMap { $0.delete(on: req) }
            .transform(to: .http200)
    }
}
