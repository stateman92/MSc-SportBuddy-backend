//
//  ExerciseControllerImpl.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct ExerciseControllerImpl { }

// MARK: - ExerciseController

extension ExerciseControllerImpl: ExerciseController {
    func exerciseGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<exerciseGetResponse> {
        req
            .repositories
            .exercises
            .queryAll()
            .map { .http200($0.map(\.dto)) }
    }

    func exercisePost(with req: Request, asAuthenticated user: User, body: ExerciseDTO) throws -> EventLoopFuture<exercisePostResponse> {
        req
            .repositories
            .exercises
            .create(body.model, transformTo: .http200)
    }

    func exercisePut(with req: Request, asAuthenticated user: User, body: ExerciseDTO) throws -> EventLoopFuture<exercisePutResponse> {
        req
            .repositories
            .exercises
            .update(body.model, transformTo: .http200)
    }

    func exerciseDelete(with req: Request, asAuthenticated user: User, exerciseId: UUID) throws -> EventLoopFuture<exerciseDeleteResponse> {
        req
            .repositories
            .exercises
            .findOrAbortAndDelete(exerciseId)
            .transform(to: .http200)
    }
}
