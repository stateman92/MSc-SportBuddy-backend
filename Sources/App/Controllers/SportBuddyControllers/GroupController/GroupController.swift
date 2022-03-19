//
//  GroupController.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct GroupController { }

extension GroupController: GroupControllerProtocol {
    func groupGet(with req: Request, asAuthenticated user: User) throws -> EventLoopFuture<groupGetResponse> {
        getGroups(of: user, on: req)
            .flatMap {
                $0
                    .map { getGroupDTO(from: $0, on: req) }
                    .flatten(on: req)
            }
            .map { .http200($0) }
    }

    func groupPost(with req: Request, asAuthenticated user: User, groupId: UUID, message: String) throws -> EventLoopFuture<groupPostResponse> {
        guard let userId = user.id else { return req.eventLoop.future(.http400) }
        return Group
            .findOrAbort(groupId, on: req)
            .flatMap { group in
                let id = UUID()
                let groupEntry = GroupEntry(id: id, message: message, timestamp: Date().secondsSince1970, sender: userId, deleted: false)
                group.groupEntries.append(id)
                return groupEntry
                    .create(on: req)
                    .flatMap { group.update(on: req) }
                    .transform(to: .http200)
            }
    }

    func groupPut(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID, modifiedMessage: String) throws -> EventLoopFuture<groupPutResponse> {
        GroupEntry
            .findOrAbortAndModifyThenTransform(groupEntryDTOId, on: req, modify: { groupEntry in
                groupEntry.message = modifiedMessage
            }, transformTo: .http200)
    }

    func groupDelete(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupDeleteResponse> {
        deleteOrUndelete(delete: true, groupEntryDTOId: groupEntryDTOId, on: req, transformTo: .http200)
    }

    func groupPatch(with req: Request, asAuthenticated user: User, groupEntryDTOId: UUID) throws -> EventLoopFuture<groupPatchResponse> {
        deleteOrUndelete(delete: false, groupEntryDTOId: groupEntryDTOId, on: req, transformTo: .http200)
    }
}

extension GroupController {
    private func getGroupEntries(for ids: [UUID], on request: Request) -> EventLoopFuture<[GroupEntry]> {
        ids
            .map { GroupEntry.findOrAbort($0, on: request) }
            .flatten(on: request.eventLoop)
    }

    private func getGroups(of user: User, on request: Request) -> EventLoopFuture<[Group]> {
        user
            .groups
            .map { Group.findOrAbort($0, on: request) }
            .flatten(on: request.eventLoop)
    }

    private func getGroupDTO(from group: Group, on request: Request) -> EventLoopFuture<GroupDTO> {
        getGroupEntries(for: group.groupEntries, on: request)
            .map { $0.map(\.dto) }
            .map { group.dto(with: $0) }
    }

    private func deleteOrUndelete<NewValue>(delete: Bool, groupEntryDTOId: UUID, on request: Request, transformTo: NewValue) -> EventLoopFuture<NewValue> {
        GroupEntry
            .find(groupEntryDTOId, on: request)
            .unwrapOrAbort()
            .flatMap {
                $0.deleted = delete
                return $0.update(on: request, transformTo: transformTo)
            }
    }
}
