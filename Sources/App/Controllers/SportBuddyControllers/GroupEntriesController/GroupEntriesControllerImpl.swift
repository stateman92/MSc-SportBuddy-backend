//
//  GroupEntriesControllerImpl.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct GroupEntriesControllerImpl { }

// MARK: - GroupController

extension GroupEntriesControllerImpl: GroupEntriesController {
    func groupEntriesGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<groupEntriesGetResponse> {
        getGroups(of: user, on: req)
            .flatMap {
                $0
                    .map { getGroupDTO(from: $0, on: req) }
                    .flatten(on: req)
            }
            .map { .http200($0) }
    }

    func groupEntriesPost(with req: Request, asAuthenticated user: User, groupId: UUID, message: String) throws -> EventLoopFuture<groupEntriesPostResponse> {
        guard let userId = user.id else { return req.eventLoop.future(.http400) }
        return req
            .repositories
            .groups
            .findOrAbort(groupId)
            .flatMap { group in
                let id = UUID()
                let groupEntry = GroupEntry(id: id, message: message, timestamp: Date().secondsSince1970, sender: userId, deleted: false)
                group.groupEntries.append(id)
                return req
                    .repositories
                    .groupEntries
                    .create(groupEntry)
                    .flatMap { req.repositories.groups.update(group) }
                    .transform(to: .http200)
            }
    }

    func groupEntriesPut(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID, modifiedMessage: String) throws -> EventLoopFuture<groupEntriesPutResponse> {
        req
            .repositories
            .groupEntries
            .findOrAbortAndModifyThenTransform(groupEntryDTOId, modify: { groupEntry in
                groupEntry.message = modifiedMessage
            }, transformTo: .http200)
    }

    func groupEntriesDelete(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupEntriesDeleteResponse> {
        deleteOrUndelete(delete: true, groupEntryDTOId: groupEntryDTOId, on: req, transformTo: .http200)
    }

    func groupEntriesPatch(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupEntriesPatchResponse> {
        deleteOrUndelete(delete: false, groupEntryDTOId: groupEntryDTOId, on: req, transformTo: .http200)
    }
}

// MARK: - Helpers

extension GroupEntriesControllerImpl {
    private func getGroupEntries(for ids: [UUID], on req: Request) -> EventLoopFuture<[GroupEntry]> {
        ids
            .map { req.repositories.groupEntries.findOrAbort($0) }
            .flatten(on: req)
    }

    private func getGroups(of user: User, on req: Request) -> EventLoopFuture<[Group]> {
        user
            .groups
            .map { req.repositories.groups.findOrAbort($0) }
            .flatten(on: req)
    }

    private func getGroupDTO(from group: Group, on req: Request) -> EventLoopFuture<GroupDTO> {
        getGroupEntries(for: group.groupEntries, on: req)
            .map { $0.map(\.dto) }
            .map { group.dto(with: $0) }
    }

    private func deleteOrUndelete<NewValue>(delete: Bool, groupEntryDTOId: UUID, on req: Request, transformTo: NewValue) -> EventLoopFuture<NewValue> {
        req
            .repositories
            .groupEntries
            .findOrAbortAndModifyThenTransform(groupEntryDTOId, modify: {
                $0.deleted = delete
            }, transformTo: transformTo)
    }
}
