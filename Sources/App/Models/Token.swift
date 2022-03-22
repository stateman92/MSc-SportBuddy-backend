//
//  Token.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Foundation

/// An object that represents a token of a user.
struct Token {
    /// The internal unique identifier of the token.
    let token: UUID

    /// The last time when the token is validated. Initially it's the generation's time.
    private var tokenGeneratedTime: Int

    /// Initialize a token.
    /// - Parameter token: the unique identifier. By default `.init()`.
    /// - Parameter tokenGeneratedTime: the token's generation's time (in seconds since 1970).
    init(token: UUID = .init(), tokenGeneratedTime: Int) {
        self.token = token
        self.tokenGeneratedTime = tokenGeneratedTime
    }

    /// Initialize a token.
    /// - Parameter token: the unique identifier. By default `.init()`.
    /// - Parameter tokenGeneratedTime: the token's generation's date. By default `.init()`.
    init(token: UUID = .init(), tokenGeneratedTime: Date = .init()) {
        self.init(token: token, tokenGeneratedTime: tokenGeneratedTime.secondsSince1970)
    }
}

extension Token {
    /// Check if the token is valid at a given time.
    /// - Parameter validityDuration: the duration during the token is valid (measured from the generation's time / last time validation's time).
    /// - Parameter targetDate: the time to check the token. By default `.init()`, which result in a check at the current time.
    /// - Returns: Whether the token is valid at the given time.
    func isValid(validityDuration: TimeInterval, at targetDate: Date = .init()) -> Bool {
        Date(secondsSince1970: tokenGeneratedTime).addingTimeInterval(validityDuration) > targetDate
    }

    /// Refresh the token, update its last validation time.
    mutating func refresh() {
        tokenGeneratedTime = Date().secondsSince1970
    }
}

extension Token: Codable {
    /// A convenience accessor of the `String` encoded value of the token.
    var encoded: String {
        guard let encoded = try? JSONEncoder().encode(self) else { return .empty }
        return String(data: encoded, encoding: .utf8) ?? .empty
    }

    /// A convenience (failable) initializer from the `String` encoded value of the token.
    /// - Parameter string: the token's encoded value.
    init?(from string: String) {
        guard let data = string.data(using: .utf8), let decoded = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        self.init(token: decoded.token, tokenGeneratedTime: decoded.tokenGeneratedTime)
    }
}
