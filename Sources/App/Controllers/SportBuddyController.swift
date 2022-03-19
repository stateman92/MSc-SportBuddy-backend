//
//  SportBuddyController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

final class SportBuddyController: BackendApiDelegate {
    @LazyInjected private var chatController: ChatControllerProtocol
    @LazyInjected private var exerciseController: ExerciseControllerProtocol
    @LazyInjected private var groupController: GroupControllerProtocol
    @LazyInjected private var userController: UserControllerProtocol
    @LazyInjected private var searchController: SearchControllerProtocol
    @LazyInjected private var groupManagingController: GroupManagingControllerProtocol
}

extension SportBuddyController {
    func testGet(with req: Request) throws -> EventLoopFuture<testGetResponse> {
        req.eventLoop.makeSucceededFuture(.http200)
    }
}

extension SportBuddyController {
    func chatGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<chatGetResponse> {
        try chatController.chatGet(with: req, asAuthenticated: user)
    }

    func chatPost(with req: Request, asAuthenticated user: User, chatId: UUID, message: String) throws -> EventLoopFuture<chatPostResponse> {
        try chatController.chatPost(with: req, asAuthenticated: user, chatId: chatId, message: message)
    }

    func chatPut(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID, modifiedMessage: String) throws -> EventLoopFuture<chatPutResponse> {
        try chatController.chatPut(with: req, asAuthenticated: user, chatEntryDTOId: chatEntryDTOId, modifiedMessage: modifiedMessage)
    }

    func chatDelete(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatDeleteResponse> {
        try chatController.chatDelete(with: req, asAuthenticated: user, chatEntryDTOId: chatEntryDTOId)
    }

    func chatPatch(with req: Request, asAuthenticated user: User, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatPatchResponse> {
        try chatController.chatPatch(with: req, asAuthenticated: user, chatEntryDTOId: chatEntryDTOId)
    }
}

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

extension SportBuddyController {
    func groupGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<groupGetResponse> {
        try groupController.groupGet(with: req, asAuthenticated: user)
    }

    func groupPost(with req: Request, asAuthenticated user: User, groupId: UUID, message: String) throws -> EventLoopFuture<groupPostResponse> {
        try groupController.groupPost(with: req, asAuthenticated: user, groupId: groupId, message: message)
    }

    func groupPut(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID, modifiedMessage: String) throws -> EventLoopFuture<groupPutResponse> {
        try groupController.groupPut(with: req, asAuthenticated: user, groupEntryDTOId: groupEntryDTOId, modifiedMessage: modifiedMessage)
    }

    func groupDelete(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupDeleteResponse> {
        try groupController.groupDelete(with: req, asAuthenticated: user, groupEntryDTOId: groupEntryDTOId)
    }

    func groupPatch(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupPatchResponse> {
        try groupController.groupPatch(with: req, asAuthenticated: user, groupEntryDTOId: groupEntryDTOId)
    }
}

extension SportBuddyController {
    func registerPost(with req: Request, name: String, email: String, password: String) throws -> EventLoopFuture<registerPostResponse> {
        try userController.registerPost(with: req, name: name, email: email, password: password)
    }

    func loginPost(with req: Request, email: String, password: String) throws -> EventLoopFuture<loginPostResponse> {
        try userController.loginPost(with: req, email: email, password: password)
    }

    func forgotPasswordPost(with req: Request, email: String) throws -> EventLoopFuture<forgotPasswordPostResponse> {
        try userController.forgotPasswordPost(with: req, email: email)
    }

    func logoutPost(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<logoutPostResponse> {
        try userController.logoutPost(with: req, asAuthenticated: user)
    }
}

extension SportBuddyController {
    func searchUserPost(with req: Request, asAuthenticated user: User, name: String) throws -> EventLoopFuture<searchUserPostResponse> {
        try searchController.searchUserPost(with: req, asAuthenticated: user, name: name)
    }
}

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
