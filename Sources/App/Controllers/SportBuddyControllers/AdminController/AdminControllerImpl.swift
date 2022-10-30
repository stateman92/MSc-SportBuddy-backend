//
//  AdminControllerImpl.swift
//  
//
//  Created by Kristof Kalai on 2022. 10. 18..
//

import Vapor

final class AdminControllerImpl {
    // MARK: Properties

    @LazyInjected private var authenticationService: AuthenticationService
}

// MARK: - AdminController

extension AdminControllerImpl: AdminController {
    func clearDatabasePost(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<clearDatabasePostResponse> {
        req
            .db
            .clear(leaveAdminWithToken: user.token?.token)
            .map { .http200 }
    }
    
    func deleteExerciseModelPost(with req: Request, asAuthenticated user: User, primaryId: UUID) throws -> EventLoopFuture<deleteExerciseModelPostResponse> {
        req
            .repositories
            .exerciseModels
            .delete(primaryId)
            .map { .http200 }
    }
    
    func exerciseModelsGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<exerciseModelsGetResponse> {
        req
            .repositories
            .exerciseModels
            .queryAll()
            .map {
                .http200(
                    $0.map {
                        .init(
                            id: $0.id ?? .init(),
                            sequence: $0.sequence.map {
                                .init(
                                    armCharacteristics: $0.armCharacteristics.dto,
                                    legCharacteristics: $0.legCharacteristics.dto,
                                    errors: $0.errors.map {
                                        .init(
                                            characteristics: $0.characteristics.dto,
                                            error: $0.error
                                        )
                                    }
                                )
                            },
                            sequenceCount: $0.sequenceCount,
                            delay: $0.delay,
                            videoId: $0.videoId,
                            name: $0.name,
                            details: $0.details
                        )
                    }
                )
            }
    }
    
    func resetDatabasePost(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<resetDatabasePostResponse> {
        req
            .db
            .reset(leaveAdminWithToken: user.token?.token)
            .map { .http200 }
    }
    
    func saveNewPasswordPost(with req: Request, requestId: UUID, newPassword: String) throws -> EventLoopFuture<saveNewPasswordPostResponse> {
        guard let hashedPassword = authenticationService.hash(password: newPassword) else {
            return req.eventLoop.future().map { .http400 }
        }
        return req
            .repositories
            .users
            .queryAll()
            .map {
                $0.first { $0.resetPasswordToken?.token == requestId }
            }
            .unwrapOrAbort()
            .flatMap {
                if $0.resetPasswordToken?.isValid(validityDuration: Constants.resetTokenValidityInterval) == true {
                    $0.password = hashedPassword
                    $0.resetPasswordToken = nil
                    return req
                        .repositories
                        .users
                        .update($0)
                        .transform(to: true)
                } else {
                    return req.eventLoop.future().transform(to: false)
                }
            }
            .map { $0 ? .http200 : .http400 }
    }
    
    func uploadExerciseModelPost(with req: Request, asAuthenticated user: User, body: ExerciseModelDTO) throws -> EventLoopFuture<uploadExerciseModelPostResponse> {
        req
            .repositories
            .exerciseModels
            .queryAll()
            .flatMap {
                if $0.contains(where: { $0.id == body.id }) {
                    return req.eventLoop.future(.http400)
                }
                return req.repositories.exerciseModels.create(.init(
                    id: body.id,
                    sequence: body.sequence.map {
                        .init(
                            armCharacteristics: .init(from: $0.armCharacteristics),
                            legCharacteristics: .init(from: $0.legCharacteristics),
                            errors: $0.errors.map {
                                .init(
                                    characteristics: .init(from: $0.characteristics),
                                    error: $0.error
                                )
                            }
                        )
                    },
                    sequenceCount: body.sequenceCount,
                    delay: body.delay,
                    videoId: body.videoId,
                    name: body.name,
                    details: body.details
                ), transformTo: .http200)
            }
    }
    
    func usersGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<usersGetResponse> {
        req
            .repositories
            .users
            .queryAll()
            .map {
                .http200($0.map {
                    UserDB(id: $0.id, name: $0.name, email: $0.email, password: $0.password, profileImage: $0.profileImage, token: $0.token?.token.uuidString, chats: $0.chats)
                })
            }
    }
}
