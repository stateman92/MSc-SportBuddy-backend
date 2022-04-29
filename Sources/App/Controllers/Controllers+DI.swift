//
//  Controllers+DI.swift
//  
//
//  Created by Kristof Kalai on 2022. 04. 29..
//

extension DependencyInjector {
    /// Register all the controllers of the application.
    static func registerControllers() {
        resolver.register { SportBuddyController() }

        resolver.register(ChatControllerProtocol.self) { ChatController() }
        resolver.register(ChatEntriesControllerProtocol.self) { ChatEntriesController() }
        resolver.register(ExerciseControllerProtocol.self) { ExerciseController() }
        resolver.register(GroupControllerProtocol.self) { GroupController() }
        resolver.register(GroupEntriesControllerProtocol.self) { GroupEntriesController() }
        resolver.register(GroupManagingControllerProtocol.self) { GroupManagingController() }
        resolver.register(SearchControllerProtocol.self) { SearchController() }
        resolver.register(UserControllerProtocol.self) { UserController() }
    }
}
