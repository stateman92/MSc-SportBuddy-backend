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
    @LazyInjected private var groupController: GroupController
    @LazyInjected private var groupEntriesController: GroupEntriesController
    @LazyInjected private var groupManagingController: GroupManagingController
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

// MARK: - GroupController

extension SportBuddyController {
    func groupPut(with req: Request, asAuthenticated user: User, groupId: UUID, body: String?, users: [UUID]?) throws -> EventLoopFuture<groupPutResponse> {
        try groupController.groupPut(with: req, asAuthenticated: user, groupId: groupId, body: body, users: users)
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

// MARK: - GroupEntriesController

extension SportBuddyController {
    func groupEntriesGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<groupEntriesGetResponse> {
        try groupEntriesController.groupEntriesGet(with: req, asAuthenticated: user)
    }

    func groupEntriesPost(with req: Request, asAuthenticated user: User, groupId: UUID, message: String) throws -> EventLoopFuture<groupEntriesPostResponse> {
        try groupEntriesController.groupEntriesPost(with: req, asAuthenticated: user, groupId: groupId, message: message)
    }

    func groupEntriesPut(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID, modifiedMessage: String) throws -> EventLoopFuture<groupEntriesPutResponse> {
        try groupEntriesController.groupEntriesPut(with: req, asAuthenticated: user, groupEntryDTOId: groupEntryDTOId, modifiedMessage: modifiedMessage)
    }

    func groupEntriesDelete(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupEntriesDeleteResponse> {
        try groupEntriesController.groupEntriesDelete(with: req, asAuthenticated: user, groupEntryDTOId: groupEntryDTOId)
    }

    func groupEntriesPatch(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupEntriesPatchResponse> {
        try groupEntriesController.groupEntriesPatch(with: req, asAuthenticated: user, groupEntryDTOId: groupEntryDTOId)
    }
}

// MARK: - GroupManagingController

extension SportBuddyController {
    func groupManagingGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<groupManagingGetResponse> {
        try groupManagingController.groupManagingGet(with: req, asAuthenticated: user)
    }

    func groupManagingDelete(with req: Request, asAuthenticated user: User, groupId: UUID) throws -> EventLoopFuture<groupManagingDeleteResponse> {
        try groupManagingController.groupManagingDelete(with: req, asAuthenticated: user, groupId: groupId)
    }

    func groupManagingPost(with req: Request, asAuthenticated user: User, groupId: UUID) throws -> EventLoopFuture<groupManagingPostResponse> {
        try groupManagingController.groupManagingPost(with: req, asAuthenticated: user, groupId: groupId)
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
}
