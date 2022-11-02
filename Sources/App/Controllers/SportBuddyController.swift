//
//  SportBuddyController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

final class SportBuddyController: BackendApiDelegate {
    @LazyInjected private var adminController: AdminController
    @LazyInjected private var chatController: ChatController
    @LazyInjected private var chatEntriesController: ChatEntriesController
    @LazyInjected private var searchController: SearchController
    @LazyInjected private var userController: UserController
}

extension SportBuddyController {
    func versionGet(with req: Request) throws -> EventLoopFuture<versionGetResponse> {
        req.eventLoop.makeSucceededFuture(.http200(Constants.version))
    }
}

// MARK: - ChatEntriesController

extension SportBuddyController {
    func chatEntriesGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<chatEntriesGetResponse> {
        try chatEntriesController.chatEntriesGet(with: req, asAuthenticated: user)
    }

    func chatEntriesPost(with req: Request, asAuthenticated user: User, chatId: UUID, message: String) throws -> EventLoopFuture<chatEntriesPostResponse> {
        try chatEntriesController.chatEntriesPost(with: req, asAuthenticated: user, chatId: chatId, message: message)
    }

    func chatEntriesPut(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID, modifiedMessage: String) throws -> EventLoopFuture<chatEntriesPutResponse> {
        try chatEntriesController.chatEntriesPut(with: req, asAuthenticated: user, chatEntryDTOId: chatEntryDTOId, modifiedMessage: modifiedMessage)
    }

    func chatEntriesDelete(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatEntriesDeleteResponse> {
        try chatEntriesController.chatEntriesDelete(with: req, asAuthenticated: user, chatEntryDTOId: chatEntryDTOId)
    }

    func chatEntriesPatch(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatEntriesPatchResponse> {
        try chatEntriesController.chatEntriesPatch(with: req, asAuthenticated: user, chatEntryDTOId: chatEntryDTOId)
    }
}

// MARK: - ChatController

extension SportBuddyController {
    func chatPut(with req: Request, asAuthenticated user: User, chatId: UUID, body: String?, users: [UUID]?) throws -> EventLoopFuture<chatPutResponse> {
        try chatController.chatPut(with: req, asAuthenticated: user, chatId: chatId, body: body, users: users)
    }
}

// MARK: - SearchController

extension SportBuddyController {
    func searchUserPost(with req: Request, asAuthenticated user: User, name: String) throws -> EventLoopFuture<searchUserPostResponse> {
        try searchController.searchUserPost(with: req, asAuthenticated: user, name: name)
    }
}

// MARK: - UserController

extension SportBuddyController {
    func registerPost(with req: Request, name: String, email: String, password: String) throws -> EventLoopFuture<registerPostResponse> {
        try userController.registerPost(with: req, name: name, email: email, password: password)
    }

    func loginPost(with req: Request, email: String, password: String) throws -> EventLoopFuture<loginPostResponse> {
        try userController.loginPost(with: req, email: email, password: password)
    }

    func adminLoginPost(with req: Request, email: String, password: String) throws -> EventLoopFuture<adminLoginPostResponse> {
        try userController.adminLoginPost(with: req, email: email, password: password)
    }

    func refreshTokenPost(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<refreshTokenPostResponse> {
        req.eventLoop.future(.http200)
    }

    func forgotPasswordPost(with req: Request, email: String) throws -> EventLoopFuture<forgotPasswordPostResponse> {
        try userController.forgotPasswordPost(with: req, email: email)
    }

    func logoutPost(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<logoutPostResponse> {
        try userController.logoutPost(with: req, asAuthenticated: user)
    }

    func imagePost(with req: Request, asAuthenticated user: User, body: String?) throws -> EventLoopFuture<imagePostResponse> {
        try userController.imagePost(with: req, asAuthenticated: user, body: body)
    }

    func userImageGet(with req: Request, asAuthenticated user: User, chatId: String) throws -> EventLoopFuture<userImageGetResponse> {
        try userController.userImageGet(with: req, asAuthenticated: user, chatId: chatId)
    }
}

// MARK: - AdminController

extension SportBuddyController {
    func clearDatabasePost(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<clearDatabasePostResponse> {
        try adminController.clearDatabasePost(with: req, asAuthenticated: user)
    }

    func deleteExerciseModelPost(with req: Request, asAuthenticated user: User, primaryId: UUID) throws -> EventLoopFuture<deleteExerciseModelPostResponse> {
        try adminController.deleteExerciseModelPost(with: req, asAuthenticated: user, primaryId: primaryId)
    }

    func exerciseModelsGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<exerciseModelsGetResponse> {
        try adminController.exerciseModelsGet(with: req, asAuthenticated: user)
    }

    func resetDatabasePost(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<resetDatabasePostResponse> {
        try adminController.resetDatabasePost(with: req, asAuthenticated: user)
    }

    func saveNewPasswordPost(with req: Request, requestId: UUID, newPassword: String) throws -> EventLoopFuture<saveNewPasswordPostResponse> {
        try adminController.saveNewPasswordPost(with: req, requestId: requestId, newPassword: newPassword)
    }

    func uploadExerciseModelPost(with req: Request, asAuthenticated user: User, body: ExerciseModelDTO) throws -> EventLoopFuture<uploadExerciseModelPostResponse> {
        try adminController.uploadExerciseModelPost(with: req, asAuthenticated: user, body: body)
    }

    func usersGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<usersGetResponse> {
        try adminController.usersGet(with: req, asAuthenticated: user)
    }
}
