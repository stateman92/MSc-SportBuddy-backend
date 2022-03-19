//
//  main.swift
//
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import App
import Vapor

/// Inject all the dependencies.
DependencyInjector.registerDependencies()

/// Setup environment.
var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)

/// Setup application.
let app = Application(env)
defer { app.shutdown() }
try app.setup()
try app.run()
