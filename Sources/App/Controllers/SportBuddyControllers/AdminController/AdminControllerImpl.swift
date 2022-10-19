//
//  AdminControllerImpl.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Vapor

struct AdminControllerImpl { }

// MARK: - AdminController

extension AdminControllerImpl: AdminController {
    func clearDatabasePost(with req: Request, asAuthenticated user: User) throws -> NIOCore.EventLoopFuture<clearDatabasePostResponse> {
        fatalError()
    }
    
    func deleteExerciseModelPost(with req: Request, asAuthenticated user: User, primaryId: UUID) throws -> NIOCore.EventLoopFuture<deleteExerciseModelPostResponse> {
        fatalError()
    }
    
    func exerciseModelsGet(with req: Request, asAuthenticated user: User) throws -> NIOCore.EventLoopFuture<exerciseModelsGetResponse> {
        fatalError()
    }
    
    func resetDatabasePost(with req: Request, asAuthenticated user: User) throws -> NIOCore.EventLoopFuture<resetDatabasePostResponse> {
        fatalError()
    }
    
    func saveNewPasswordPost(with req: Request, asAuthenticated user: User, requestId: UUID, newPassword: String) throws -> NIOCore.EventLoopFuture<saveNewPasswordPostResponse> {
        fatalError()
    }
    
    func uploadExerciseModelPost(with req: Request, asAuthenticated user: User, body: ExerciseModelDTO) throws -> NIOCore.EventLoopFuture<uploadExerciseModelPostResponse> {
        fatalError()
    }
    
    func usersGet(with req: Request, asAuthenticated user: User) throws -> NIOCore.EventLoopFuture<usersGetResponse> {
        fatalError()
    }
}
