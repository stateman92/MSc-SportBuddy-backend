//
//  WebSocketHandlerImpl.swift
//
//
//  Created by Kristof Kalai on 2022. 07. 30..
//

import Vapor

final class WebSocketHandlerImpl {
    // MARK: Properties

    private let clients: WebSocketStorage
    @LazyInjected private var coderService: CoderService

    // MARK: Initialization

    init(eventLoop: EventLoop) {
        clients = WebSocketStorage(eventLoop: eventLoop)
    }
}

// MARK: - WebSocketHandler

extension WebSocketHandlerImpl: WebSocketHandler {
    func connect(_ req: Request, _ ws: WebSocket) {
        ws.onText { [unowned self] webSocket, string in
            if let connection: WSConnectionDTO = coderService.decode(string: string) {
                handle(connection, req, webSocket)
            }
            if let chat: ChatDTO = coderService.decode(string: string) {
                handle(chat, req, webSocket)
            }
            if let liveFeed: LiveFeedDTO = coderService.decode(string: string) {
                handle(liveFeed, req, webSocket)
            }
        }
    }
}

// MARK: - Private methods

extension WebSocketHandlerImpl {
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
                        let firstChat = self.getChatDTO(from: chatDto, otherParty: chatDto.users[0], on: req)
                        let secondChat = self.getChatDTO(from: chatDto, otherParty: chatDto.users[1], on: req)
                        return [firstChat, secondChat].flatten(on: req)
                    }
                    .flatMap { (chats: [ChatDTO]) -> EventLoopFuture<Void> in
                        guard let firstChat: String = self.coderService.encode(object: chats[0]),
                        let secondChat: String = self.coderService.encode(object: chats[1]) else {
                            return req.eventLoop.future()
                        }
                        chats[0].users.forEach { userInChat in
                            if userInChat == chats[0].users[0] {
                                self.clients.find(userInChat)?.send(secondChat)
                            } else {
                                self.clients.find(userInChat)?.send(firstChat)
                            }
                        }
                        return req.eventLoop.future()
                    }
            }
            .waitCarefully(on: req)
    }

    private func handle(_ liveFeedDto: LiveFeedDTO, _ req: Request, _ webSocket: WebSocket) {
        req
            .eventLoop
            .future()
            .flatMap { _ -> EventLoopFuture<String> in
                req
                    .repositories
                    .users
                    .findOrAbort(liveFeedDto.sender)
                    .map(\.profileImage)
            }
            .flatMap { image -> EventLoopFuture<Void> in
                let notOursDto = LiveFeedResponseDTO(image: image, message: liveFeedDto.message, date: liveFeedDto.date)
                let oursDto = LiveFeedResponseDTO(image: nil, message: liveFeedDto.message, date: liveFeedDto.date)
                guard let notOursResponse: String = self.coderService.encode(object: notOursDto),
                      let oursResponse: String = self.coderService.encode(object: oursDto) else {
                    return req.eventLoop.future()
                }
                self.clients.forEach { client in
                    if client.identifier == liveFeedDto.sender {
                        client.send(oursResponse)
                    } else {
                        client.send(notOursResponse)
                    }
                }
                return req.eventLoop.future()
            }
            .waitCarefully(on: req)
    }
}

// MARK: - Helpers

extension WebSocketHandlerImpl {
    private func getChatDTO(from chat: Chat, otherParty: UUID, on req: Request) -> EventLoopFuture<ChatDTO> {
        getChatEntries(for: chat.chatEntries, on: req)
            .map { $0.map(\.dto) }
            .flatMap { entries in
                req.repositories.users.findOrAbort(otherParty).map(\.name).map {
                    (entries, $0)
                }
            }
            .map { chat.dto(with: $0.0, otherParty: $0.1) }
    }

    private func getChatEntries(for ids: [UUID], on req: Request) -> EventLoopFuture<[ChatEntry]> {
        ids
            .map { req.repositories.chatEntries.findOrAbort($0) }
            .flatten(on: req)
    }
}
