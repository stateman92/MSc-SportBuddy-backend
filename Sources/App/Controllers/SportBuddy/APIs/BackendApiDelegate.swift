import Vapor
// BackendApiDelegate.swift
//
// Generated by vapor-server-codegen
// https://github.com/thecheatah/SwiftVapor-swagger-codegen
// Template Input: /APIs.Backend


public enum chatEntriesDeleteResponse: ResponseEncodable {
  case http200
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200:
      let response = Response()
      response.status = HTTPStatus(statusCode: 200)
      return request.eventLoop.makeSucceededFuture(response)
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum chatEntriesGetResponse: ResponseEncodable {
  case http200([ChatDTO])
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200(let content):
      return content.encodeResponse(for: request).map { (response: Response) -> (Response) in
        response.status = HTTPStatus(statusCode: 200)
        return response
      }
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum chatEntriesPatchResponse: ResponseEncodable {
  case http200
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200:
      let response = Response()
      response.status = HTTPStatus(statusCode: 200)
      return request.eventLoop.makeSucceededFuture(response)
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum chatEntriesPostResponse: ResponseEncodable {
  case http200
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200:
      let response = Response()
      response.status = HTTPStatus(statusCode: 200)
      return request.eventLoop.makeSucceededFuture(response)
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum chatEntriesPutResponse: ResponseEncodable {
  case http200
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200:
      let response = Response()
      response.status = HTTPStatus(statusCode: 200)
      return request.eventLoop.makeSucceededFuture(response)
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum chatPutResponse: ResponseEncodable {
  case http200
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200:
      let response = Response()
      response.status = HTTPStatus(statusCode: 200)
      return request.eventLoop.makeSucceededFuture(response)
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum exerciseDeleteResponse: ResponseEncodable {
  case http200
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200:
      let response = Response()
      response.status = HTTPStatus(statusCode: 200)
      return request.eventLoop.makeSucceededFuture(response)
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum exerciseGetResponse: ResponseEncodable {
  case http200([ExerciseDTO])
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200(let content):
      return content.encodeResponse(for: request).map { (response: Response) -> (Response) in
        response.status = HTTPStatus(statusCode: 200)
        return response
      }
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum exercisePostResponse: ResponseEncodable {
  case http200
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200:
      let response = Response()
      response.status = HTTPStatus(statusCode: 200)
      return request.eventLoop.makeSucceededFuture(response)
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum exercisePutResponse: ResponseEncodable {
  case http200
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200:
      let response = Response()
      response.status = HTTPStatus(statusCode: 200)
      return request.eventLoop.makeSucceededFuture(response)
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum forgotPasswordPostResponse: ResponseEncodable {
  case http200
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200:
      let response = Response()
      response.status = HTTPStatus(statusCode: 200)
      return request.eventLoop.makeSucceededFuture(response)
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum imagePostResponse: ResponseEncodable {
  case http200(UserDTO)
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200(let content):
      return content.encodeResponse(for: request).map { (response: Response) -> (Response) in
        response.status = HTTPStatus(statusCode: 200)
        return response
      }
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum loginPostResponse: ResponseEncodable {
  case http200(UserResponseDTO)
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200(let content):
      return content.encodeResponse(for: request).map { (response: Response) -> (Response) in
        response.status = HTTPStatus(statusCode: 200)
        return response
      }
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum logoutPostResponse: ResponseEncodable {
  case http200
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200:
      let response = Response()
      response.status = HTTPStatus(statusCode: 200)
      return request.eventLoop.makeSucceededFuture(response)
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum refreshTokenPostResponse: ResponseEncodable {
  case http200
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200:
      let response = Response()
      response.status = HTTPStatus(statusCode: 200)
      return request.eventLoop.makeSucceededFuture(response)
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum registerPostResponse: ResponseEncodable {
  case http200(UserResponseDTO)
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200(let content):
      return content.encodeResponse(for: request).map { (response: Response) -> (Response) in
        response.status = HTTPStatus(statusCode: 200)
        return response
      }
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum searchUserPostResponse: ResponseEncodable {
  case http200([UserDTO])
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200(let content):
      return content.encodeResponse(for: request).map { (response: Response) -> (Response) in
        response.status = HTTPStatus(statusCode: 200)
        return response
      }
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum testGetResponse: ResponseEncodable {
  case http200
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200:
      let response = Response()
      response.status = HTTPStatus(statusCode: 200)
      return request.eventLoop.makeSucceededFuture(response)
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}


public enum userImageGetResponse: ResponseEncodable {
  case http200(String)
  case http400

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200(let content):
      return content.encodeResponse(for: request).map { (response: Response) -> (Response) in
        response.status = HTTPStatus(statusCode: 200)
        return response
      }
    case .http400:
      let response = Response()
      response.status = HTTPStatus(statusCode: 400)
      return request.eventLoop.makeSucceededFuture(response)
    }
  }
}

public protocol BackendApiDelegate {
  associatedtype AuthType
  /**
  DELETE /chatEntries
  Delete a chat message */
  func chatEntriesDelete(with req: Request, asAuthenticated user: AuthType, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatEntriesDeleteResponse>
  /**
  GET /chatEntries
  Get a chat's messages */
  func chatEntriesGet(with req: Request, asAuthenticated user: AuthType) throws -> EventLoopFuture<chatEntriesGetResponse>
  /**
  PATCH /chatEntries
  Undo message deletion */
  func chatEntriesPatch(with req: Request, asAuthenticated user: AuthType, chatEntryDTOId: UUID) throws -> EventLoopFuture<chatEntriesPatchResponse>
  /**
  POST /chatEntries
  Send a chat message */
  func chatEntriesPost(with req: Request, asAuthenticated user: AuthType, chatId: UUID, message: String) throws -> EventLoopFuture<chatEntriesPostResponse>
  /**
  PUT /chatEntries
  Modify a chat message */
  func chatEntriesPut(with req: Request, asAuthenticated user: AuthType, chatEntryDTOId: UUID, modifiedMessage: String) throws -> EventLoopFuture<chatEntriesPutResponse>
  /**
  PUT /chat
  Update a chat */
  func chatPut(with req: Request, asAuthenticated user: AuthType, chatId: UUID, body: String?, users: [UUID]?) throws -> EventLoopFuture<chatPutResponse>
  /**
  DELETE /exercise
  Delete an exercise */
  func exerciseDelete(with req: Request, asAuthenticated user: AuthType, exerciseId: UUID) throws -> EventLoopFuture<exerciseDeleteResponse>
  /**
  GET /exercise
  Get the exercises */
  func exerciseGet(with req: Request, asAuthenticated user: AuthType) throws -> EventLoopFuture<exerciseGetResponse>
  /**
  POST /exercise
  Post an exercises */
  func exercisePost(with req: Request, asAuthenticated user: AuthType, body: ExerciseDTO) throws -> EventLoopFuture<exercisePostResponse>
  /**
  PUT /exercise
  Modify an exercise */
  func exercisePut(with req: Request, asAuthenticated user: AuthType, body: ExerciseDTO) throws -> EventLoopFuture<exercisePutResponse>
  /**
  POST /forgotPassword
  Send a recovery email to an existing user of the application or an admin */
  func forgotPasswordPost(with req: Request, email: String) throws -> EventLoopFuture<forgotPasswordPostResponse>
  /**
  POST /image
  Upload an image of the user */
  func imagePost(with req: Request, asAuthenticated user: AuthType, body: String?) throws -> EventLoopFuture<imagePostResponse>
  /**
  POST /login
  Login an existing user of the application or an admin */
  func loginPost(with req: Request, email: String, password: String) throws -> EventLoopFuture<loginPostResponse>
  /**
  POST /logout
  Logout an existing user of the application or an admin */
  func logoutPost(with req: Request, asAuthenticated user: AuthType) throws -> EventLoopFuture<logoutPostResponse>
  /**
  POST /refreshToken
  Refresh the stored token */
  func refreshTokenPost(with req: Request, asAuthenticated user: AuthType) throws -> EventLoopFuture<refreshTokenPostResponse>
  /**
  POST /register
  Register a new user in the application */
  func registerPost(with req: Request, name: String, email: String, password: String) throws -> EventLoopFuture<registerPostResponse>
  /**
  POST /searchUser
  Search a user */
  func searchUserPost(with req: Request, asAuthenticated user: AuthType, name: String) throws -> EventLoopFuture<searchUserPostResponse>
  /**
  GET /test
  Test */
  func testGet(with req: Request) throws -> EventLoopFuture<testGetResponse>
  /**
  GET /userImage
  Image gathering of a chat (user) */
  func userImageGet(with req: Request, asAuthenticated user: AuthType, chatId: String) throws -> EventLoopFuture<userImageGetResponse>
}
