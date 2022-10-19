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
    func repository<T>(schema: Constants.Schema) -> RepositoryImpl<T> {
        guard let result = make(schema) as? RepositoryImpl<T> else {
            fatalError("Repository<\(T.self)> repository didn't set.")
        }
        return result
    }
}

extension RepositoryFactory {
    /// The repository of the `Chat` objects.
    var chats: RepositoryImpl<Chat> {
        repository(schema: .chats)
    }

    /// The repository of the `ChatEntry` objects.
    var chatEntries: RepositoryImpl<ChatEntry> {
        repository(schema: .chatEntries)
    }

    /// The repository of the `User` objects.
    var users: RepositoryImpl<User> {
        repository(schema: .users)
    }

    /// The repository of the `ExerciseModel` objects.
    var exerciseModels: RepositoryImpl<ExerciseModel> {
        repository(schema: .exerciseModels)
    }
}
