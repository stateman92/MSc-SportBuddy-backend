//
//  SportBuddyController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

final class SportBuddyController: BackendApiDelegate {
    @LazyInjected private var chatController: ChatController
    @LazyInjected private var chatEntriesController: ChatEntriesController
    @LazyInjected private var exerciseController: ExerciseController
    @LazyInjected private var searchController: SearchController
    @LazyInjected private var userController: UserController
}

extension SportBuddyController {
    func testGet(with req: Request) throws -> EventLoopFuture<testGetResponse> {
        req.eventLoop.makeSucceededFuture(.http200)
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

// MARK: - ExerciseController

extension SportBuddyController {
    func exerciseGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<exerciseGetResponse> {
        try exerciseController.exerciseGet(with: req, asAuthenticated: user)
    }

    func exercisePost(with req: Request, asAuthenticated user: User, body: ExerciseDTO) throws -> EventLoopFuture<exercisePostResponse> {
        try exerciseController.exercisePost(with: req, asAuthenticated: user, body: body)
    }

    func exercisePut(with req: Request, asAuthenticated user: User, body: ExerciseDTO) throws -> EventLoopFuture<exercisePutResponse> {
        try exerciseController.exercisePut(with: req, asAuthenticated: user, body: body)
    }

    func exerciseDelete(with req: Request, asAuthenticated user: User, exerciseId: UUID) throws -> EventLoopFuture<exerciseDeleteResponse> {
        try exerciseController.exerciseDelete(with: req, asAuthenticated: user, exerciseId: exerciseId)
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
