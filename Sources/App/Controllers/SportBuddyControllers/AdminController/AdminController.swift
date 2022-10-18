//
//  AdminController.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Vapor

protocol AdminController {
    func clearDatabasePost(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<clearDatabasePostResponse>
    func deleteExerciseModelPost(with req: Request, asAuthenticated user: User, primaryId: UUID) throws -> EventLoopFuture<deleteExerciseModelPostResponse>
    func exerciseModelsGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<exerciseModelsGetResponse>
    func resetDatabasePost(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<resetDatabasePostResponse>
    func saveNewPasswordPost(with req: Request, asAuthenticated user: User, requestId: UUID, newPassword: String) throws -> EventLoopFuture<saveNewPasswordPostResponse>
    func uploadExerciseModelPost(with req: Request, asAuthenticated user: User, body: ExerciseModelDTO) throws -> EventLoopFuture<uploadExerciseModelPostResponse>
    func usersGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<usersGetResponse>
}
