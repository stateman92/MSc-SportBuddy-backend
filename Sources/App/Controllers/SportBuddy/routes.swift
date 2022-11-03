import Vapor
import RoutingKit

// routes.swift
//
// Generated by vapor-server-codegen
// https://github.com/thecheatah/SwiftVapor-swagger-codegen
// Template Input: 

extension String {
  var asPathComponents: [PathComponent] {
    return self.split(separator: "/").map {
      if $0.starts(with: "{") && $0.hasSuffix("}") {
        let start = $0.index($0.startIndex, offsetBy: 1)
        let end = $0.index($0.endIndex, offsetBy: -1)
        return PathComponent.parameter(String($0[start..<end]))
      } else {
        return PathComponent.constant(.init($0))
      }
    }
  }
}

public protocol AuthenticationMiddleware: Middleware {
  associatedtype AuthType: Authenticatable
  func authType() -> AuthType.Type
}

//Used when auth is not used
public class DummyAuthType: Authenticatable {}

public func routes<authForBearer: AuthenticationMiddleware, backend: BackendApiDelegate>
  (_ app: RoutesBuilder, backend: backend, authForBearer: authForBearer)
  throws
  where authForBearer.AuthType == backend.AuthType
  {
  let groupForBearer = app.grouped([authForBearer])
  //for backend
  app.on(.POST, "/adminLogin".asPathComponents) { (request: Request) -> EventLoopFuture<adminLoginPostResponse> in
    let emailOptional = try? request.query.get(String.self, at: "email")
    guard let email = emailOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter email")
    }
    let passwordOptional = try? request.query.get(String.self, at: "password")
    guard let password = passwordOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter password")
    }
    return try backend.adminLoginPost(with: request, email: email, password: password)
  }
  groupForBearer.on(.DELETE, "/chatEntries".asPathComponents) { (request: Request) -> EventLoopFuture<chatEntriesDeleteResponse> in
    let chatEntryDTOIdOptional = try? request.query.get(UUID.self, at: "chatEntryDTOId")
    guard let chatEntryDTOId = chatEntryDTOIdOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter chatEntryDTOId")
    }
    return try backend.chatEntriesDelete(with: request, asAuthenticated: request.auth.require(authForBearer.authType()), chatEntryDTOId: chatEntryDTOId)
  }
  groupForBearer.on(.GET, "/chatEntries".asPathComponents) { (request: Request) -> EventLoopFuture<chatEntriesGetResponse> in
    return try backend.chatEntriesGet(with: request, asAuthenticated: request.auth.require(authForBearer.authType()))
  }
  groupForBearer.on(.PATCH, "/chatEntries".asPathComponents) { (request: Request) -> EventLoopFuture<chatEntriesPatchResponse> in
    let chatEntryDTOIdOptional = try? request.query.get(UUID.self, at: "chatEntryDTOId")
    guard let chatEntryDTOId = chatEntryDTOIdOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter chatEntryDTOId")
    }
    return try backend.chatEntriesPatch(with: request, asAuthenticated: request.auth.require(authForBearer.authType()), chatEntryDTOId: chatEntryDTOId)
  }
  groupForBearer.on(.POST, "/chatEntries".asPathComponents) { (request: Request) -> EventLoopFuture<chatEntriesPostResponse> in
    let chatIdOptional = try? request.query.get(UUID.self, at: "chatId")
    guard let chatId = chatIdOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter chatId")
    }
    let messageOptional = try? request.query.get(String.self, at: "message")
    guard let message = messageOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter message")
    }
    return try backend.chatEntriesPost(with: request, asAuthenticated: request.auth.require(authForBearer.authType()), chatId: chatId, message: message)
  }
  groupForBearer.on(.PUT, "/chatEntries".asPathComponents) { (request: Request) -> EventLoopFuture<chatEntriesPutResponse> in
    let chatEntryDTOIdOptional = try? request.query.get(UUID.self, at: "chatEntryDTOId")
    guard let chatEntryDTOId = chatEntryDTOIdOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter chatEntryDTOId")
    }
    let modifiedMessageOptional = try? request.query.get(String.self, at: "modifiedMessage")
    guard let modifiedMessage = modifiedMessageOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter modifiedMessage")
    }
    return try backend.chatEntriesPut(with: request, asAuthenticated: request.auth.require(authForBearer.authType()), chatEntryDTOId: chatEntryDTOId, modifiedMessage: modifiedMessage)
  }
  groupForBearer.on(.PUT, "/chat".asPathComponents) { (request: Request) -> EventLoopFuture<chatPutResponse> in
    let chatIdOptional = try? request.query.get(UUID.self, at: "chatId")
    guard let chatId = chatIdOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter chatId")
    }
    let users = try? request.query.get([UUID].self, at: "users")
    let body = try request.content.decode(String.self)
    return try backend.chatPut(with: request, asAuthenticated: request.auth.require(authForBearer.authType()), chatId: chatId, body: body, users: users)
  }
  groupForBearer.on(.POST, "/clearDatabase".asPathComponents) { (request: Request) -> EventLoopFuture<clearDatabasePostResponse> in
    return try backend.clearDatabasePost(with: request, asAuthenticated: request.auth.require(authForBearer.authType()))
  }
  groupForBearer.on(.POST, "/deleteExerciseModel".asPathComponents) { (request: Request) -> EventLoopFuture<deleteExerciseModelPostResponse> in
    let primaryIdOptional = try? request.query.get(UUID.self, at: "primaryId")
    guard let primaryId = primaryIdOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter primaryId")
    }
    return try backend.deleteExerciseModelPost(with: request, asAuthenticated: request.auth.require(authForBearer.authType()), primaryId: primaryId)
  }
  groupForBearer.on(.GET, "/exerciseModels".asPathComponents) { (request: Request) -> EventLoopFuture<exerciseModelsGetResponse> in
    return try backend.exerciseModelsGet(with: request, asAuthenticated: request.auth.require(authForBearer.authType()))
  }
  groupForBearer.on(.POST, "/exerciseModels".asPathComponents) { (request: Request) -> EventLoopFuture<exerciseModelsPostResponse> in
    let body = try request.content.decode(ExerciseModelDTO.self)
    return try backend.exerciseModelsPost(with: request, asAuthenticated: request.auth.require(authForBearer.authType()), body: body)
  }
  app.on(.POST, "/forgotPassword".asPathComponents) { (request: Request) -> EventLoopFuture<forgotPasswordPostResponse> in
    let emailOptional = try? request.query.get(String.self, at: "email")
    guard let email = emailOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter email")
    }
    return try backend.forgotPasswordPost(with: request, email: email)
  }
  groupForBearer.on(.POST, "/image".asPathComponents) { (request: Request) -> EventLoopFuture<imagePostResponse> in
    let body = try request.content.decode(String.self)
    return try backend.imagePost(with: request, asAuthenticated: request.auth.require(authForBearer.authType()), body: body)
  }
  app.on(.POST, "/login".asPathComponents) { (request: Request) -> EventLoopFuture<loginPostResponse> in
    let emailOptional = try? request.query.get(String.self, at: "email")
    guard let email = emailOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter email")
    }
    let passwordOptional = try? request.query.get(String.self, at: "password")
    guard let password = passwordOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter password")
    }
    return try backend.loginPost(with: request, email: email, password: password)
  }
  groupForBearer.on(.POST, "/logout".asPathComponents) { (request: Request) -> EventLoopFuture<logoutPostResponse> in
    return try backend.logoutPost(with: request, asAuthenticated: request.auth.require(authForBearer.authType()))
  }
  groupForBearer.on(.POST, "/refreshToken".asPathComponents) { (request: Request) -> EventLoopFuture<refreshTokenPostResponse> in
    return try backend.refreshTokenPost(with: request, asAuthenticated: request.auth.require(authForBearer.authType()))
  }
  app.on(.POST, "/register".asPathComponents) { (request: Request) -> EventLoopFuture<registerPostResponse> in
    let nameOptional = try? request.query.get(String.self, at: "name")
    guard let name = nameOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter name")
    }
    let emailOptional = try? request.query.get(String.self, at: "email")
    guard let email = emailOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter email")
    }
    let passwordOptional = try? request.query.get(String.self, at: "password")
    guard let password = passwordOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter password")
    }
    return try backend.registerPost(with: request, name: name, email: email, password: password)
  }
  groupForBearer.on(.POST, "/resetDatabase".asPathComponents) { (request: Request) -> EventLoopFuture<resetDatabasePostResponse> in
    return try backend.resetDatabasePost(with: request, asAuthenticated: request.auth.require(authForBearer.authType()))
  }
  app.on(.POST, "/saveNewPassword".asPathComponents) { (request: Request) -> EventLoopFuture<saveNewPasswordPostResponse> in
    let requestIdOptional = try? request.query.get(UUID.self, at: "requestId")
    guard let requestId = requestIdOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter requestId")
    }
    let newPasswordOptional = try? request.query.get(String.self, at: "newPassword")
    guard let newPassword = newPasswordOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter newPassword")
    }
    return try backend.saveNewPasswordPost(with: request, requestId: requestId, newPassword: newPassword)
  }
  groupForBearer.on(.POST, "/searchUser".asPathComponents) { (request: Request) -> EventLoopFuture<searchUserPostResponse> in
    let nameOptional = try? request.query.get(String.self, at: "name")
    guard let name = nameOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter name")
    }
    return try backend.searchUserPost(with: request, asAuthenticated: request.auth.require(authForBearer.authType()), name: name)
  }
  groupForBearer.on(.GET, "/userImage".asPathComponents) { (request: Request) -> EventLoopFuture<userImageGetResponse> in
    let chatIdOptional = try? request.query.get(String.self, at: "chatId")
    guard let chatId = chatIdOptional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter chatId")
    }
    return try backend.userImageGet(with: request, asAuthenticated: request.auth.require(authForBearer.authType()), chatId: chatId)
  }
  groupForBearer.on(.GET, "/users".asPathComponents) { (request: Request) -> EventLoopFuture<usersGetResponse> in
    return try backend.usersGet(with: request, asAuthenticated: request.auth.require(authForBearer.authType()))
  }
  app.on(.GET, "/version".asPathComponents) { (request: Request) -> EventLoopFuture<versionGetResponse> in
    return try backend.versionGet(with: request)
  }
}

