//
//  Token.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Foundation

struct Token {
    let token: UUID
    private var tokenGeneratedTime: Int

    init(token: UUID = .init(), tokenGeneratedTime: Int) {
        self.token = token
        self.tokenGeneratedTime = tokenGeneratedTime
    }

    init(token: UUID = .init(), tokenGeneratedTime: Date = .init()) {
        self.init(token: token, tokenGeneratedTime: tokenGeneratedTime.secondsSince1970)
    }
}

extension Token {
    func isValid(validityDuration: TimeInterval, at targetDate: Date = .init()) -> Bool {
        Date(secondsSince1970: tokenGeneratedTime).addingTimeInterval(validityDuration) > targetDate
    }

    mutating func refresh() {
        tokenGeneratedTime = Date().secondsSince1970
    }
}

extension Token: Codable {
    var encoded: String {
        guard let encoded = try? JSONEncoder().encode(self) else { return .empty }
        return String(data: encoded, encoding: .utf8) ?? .empty
    }

    init?(from string: String) {
        guard let data = string.data(using: .utf8), let decoded = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        self.init(token: decoded.token, tokenGeneratedTime: decoded.tokenGeneratedTime)
    }
}
