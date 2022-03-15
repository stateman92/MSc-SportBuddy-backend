//
//  Email.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import SendGrid

struct Email {
    let email: String
    let name: String?

    init(email: String, name: String? = nil) {
        self.email = email
        self.name = name
    }
}

extension Email {
    var sendGridEmail: EmailAddress {
        .init(email: email, name: name)
    }
}
