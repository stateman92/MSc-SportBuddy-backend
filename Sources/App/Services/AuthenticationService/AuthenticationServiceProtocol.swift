//
//  AuthenticationServiceProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

protocol AuthenticationServiceProtocol: Initable {
    func hash(password: String?) -> String?
    func isValid(password: String?, hashedPassword: String) -> Bool
    func isValid(email: String) -> Bool
}
