//
//  RepositoryFactory+Extensions.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 20..
//

extension RepositoryFactory {
    /// Get a repository of the given schema.
    /// - Parameter schema: the schema of the desired repository.
    /// - Returns: The repository.
    func repository<T>(schema: Constants.Schema) -> Repository<T> {
        guard let result = make(schema) as? Repository<T> else {
            fatalError("Repository<\(T.self)> repository didn't set.")
        }
        return result
    }
}

extension RepositoryFactory {
    /// The repository of the `Chat` objects.
    var chats: Repository<Chat> {
        repository(schema: .chats)
    }

    /// The repository of the `ChatEntry` objects.
    var chatEntries: Repository<ChatEntry> {
        repository(schema: .chatEntries)
    }

    /// The repository of the `Group` objects.
    var groups: Repository<Group> {
        repository(schema: .groups)
    }

    /// The repository of the `GroupEntry` objects.
    var groupEntries: Repository<GroupEntry> {
        repository(schema: .groupEntries)
    }

    /// The repository of the `User` objects.
    var users: Repository<User> {
        repository(schema: .users)
    }

    /// The repository of the `Exercise` objects.
    var exercises: Repository<Exercise> {
        repository(schema: .exercises)
    }
}
