//
//  main.swift
//
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import App
import Vapor

DependencyInjector.registerDependencies()
var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }
try app.setup()
try app.run()
