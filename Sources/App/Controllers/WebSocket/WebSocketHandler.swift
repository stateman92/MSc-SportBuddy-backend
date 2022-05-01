//
//  WebSocketHandler.swift
//  
//
//  Created by Kristof Kalai on 2022. 04. 29..
//

import Vapor

final class WebSocketHandler {
    // MARK: Properties

    private let clients: WebSocketStorage
    @LazyInjected private var coderService: CoderServiceProtocol

    // MARK: Initialization

    init(eventLoop: EventLoop) {
        clients = WebSocketStorage(eventLoop: eventLoop)
    }
}

// MARK: - Public methods

extension WebSocketHandler {
    func connect(_ req: Request, _ ws: WebSocket) {
        ws.onText { [unowned self] webSocket, string in
            if let connection: WSConnectionDTO = coderService.decode(string: string) {
                handle(connection, req, webSocket)
            }
            if let chat: ChatDTO = coderService.decode(string: string) {
                handle(chat, req, webSocket)
            }
        }
    }
}

// MARK: - Private methods

extension WebSocketHandler {
    private func handle(_ connectionDto: WSConnectionDTO, _ req: Request, _ webSocket: WebSocket) {
        clients.add(.init(id: connectionDto.clientIdentifier, socket: webSocket))
    }

    private func handle(_ chatDto: ChatDTO, _ req: Request, _ webSocket: WebSocket) {
        guard let newChatEntry = chatDto.chatEntries.first else { return }
        req
            .repositories
            .chats
            .find(chatDto.primaryId)
            .flatMap { chat -> EventLoopFuture<UUID> in
                if chat != nil {
                    return req
                        .repositories
                        .chatEntries
                        .create(newChatEntry.model)
                        .flatMap {
                            req
                                .repositories
                                .chats
                                .findOrAbortAndModifyThenTransform(chatDto.primaryId, modify: { chat in
                                    chat.chatEntries.append(newChatEntry.primaryId)
                                }, transformTo: chatDto.primaryId)
                        }
                } else {
                    return req
                        .repositories
                        .chats
                        .create(chatDto.model)
                        .flatMap {
                            req
                                .repositories
                                .chatEntries
                                .create(newChatEntry.model)
                        }
                        .transform(to: chatDto.primaryId)
                }
            }
            .flatMap { chatId -> EventLoopFuture<Void> in
                chatDto.users.map { userInChat in
                    req
                        .repositories
                        .users
                        .findOrAbortAndModify(userInChat) { user in
                            if !user.chats.contains(chatId) {
                                user.chats.append(chatId)
                            }
                        }
                }
                .flatten(on: req)
            }
            .flatMap { _ -> EventLoopFuture<Void> in
                req
                    .repositories
                    .chats
                    .findOrAbort(chatDto.primaryId)
                    .flatMap { chatDto in
                        self.getChatDTO(from: chatDto, on: req)
                    }
                    .flatMap { chat -> EventLoopFuture<Void> in
                        guard let response: String = self.coderService.encode(object: chat) else {
                            return req.eventLoop.future()
                        }
                        chat.users.forEach { userInChat in
                            self.clients.find(userInChat)?.send(response)
                        }
                        return req.eventLoop.future()
                    }
            }
            .waitCarefully(on: req)
    }
}

// MARK: - Helpers

extension WebSocketHandler {
    private func getChatDTO(from chat: Chat, on req: Request) -> EventLoopFuture<ChatDTO> {
        getChatEntries(for: chat.chatEntries, on: req)
            .map { $0.map(\.dto) }
            .map { chat.dto(with: $0) }
    }

    private func getChatEntries(for ids: [UUID], on req: Request) -> EventLoopFuture<[ChatEntry]> {
        ids
            .map { req.repositories.chatEntries.findOrAbort($0) }
            .flatten(on: req)
    }
}
