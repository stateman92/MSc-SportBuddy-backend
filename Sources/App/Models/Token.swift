//
//  Token.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Foundation

struct Token: Codable {
    let token: UUID
    private var tokenGeneratedTime: Int

    init(token: UUID, tokenGeneratedTime: Int) {
        self.token = token
        self.tokenGeneratedTime = tokenGeneratedTime
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
