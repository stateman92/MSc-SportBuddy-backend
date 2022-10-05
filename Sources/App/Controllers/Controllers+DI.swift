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

        resolver.register(ChatController.self) { ChatControllerImpl() }
        resolver.register(ChatEntriesController.self) { ChatEntriesControllerImpl() }
        resolver.register(ExerciseController.self) { ExerciseControllerImpl() }
        resolver.register(SearchController.self) { SearchControllerImpl() }
        resolver.register(UserController.self) { UserControllerImpl() }

        resolver.register(WebSocketHandler.self) { _, args in
            WebSocketHandlerImpl(eventLoop: args.get())
        }
    }
}
