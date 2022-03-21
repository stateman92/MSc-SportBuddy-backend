//
//  RepositoryFactory+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 20..
//

extension RepositoryFactory {
    func repository<T>(schema: Constants.Schema) -> Repository<T> {
        guard let result = make(schema) as? Repository<T> else {
            fatalError("Repository<\(T.self)> repository didn't set.")
        }
        return result
    }
}

extension RepositoryFactory {
    var chats: Repository<Chat> {
        repository(schema: .chats)
    }

    var chatEntries: Repository<ChatEntry> {
        repository(schema: .chatEntries)
    }

    var groups: Repository<Group> {
        repository(schema: .groups)
    }

    var groupEntries: Repository<GroupEntry> {
        repository(schema: .groupEntries)
    }

    var users: Repository<User> {
        repository(schema: .users)
    }

    var exercises: Repository<Exercise> {
        repository(schema: .exercises)
    }
}
