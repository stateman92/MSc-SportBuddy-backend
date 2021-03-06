//
//  AuthenticationService.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

struct AuthenticationService { }

extension AuthenticationService: AuthenticationServiceProtocol {
    /// Hash a password.
    /// - Parameter password: the plain text password.
    /// - Returns: The hashed password.
    func hash(password: String?) -> String? {
        guard let password = password, isValid(password: password) else { return nil }
        return try? Bcrypt.hash(password)
    }

    /// Check if the given password is correct based on the hashed password.
    /// - Parameter password: the plain text password.
    /// - Parameter hashedPassword: the hashed password.
    /// - Returns: Whether the password is correct.
    func isValid(password: String?, hashedPassword: String) -> Bool {
        guard let password = password else { return false }
        return (try? Bcrypt.verify(password, created: hashedPassword)) == true
    }

    /// Check if the given email is valid.
    /// - Parameter email: the email.
    /// - Returns: Whether the email is valid.
    /// - Note: A `true` return value doesn't mean that the email is indeed exists.
    func isValid(email: String) -> Bool {
        email.contains("@") &&
        email.firstIndex(of: "@") == email.lastIndex(of: "@") &&
        email.split(separator: "@").first?.isEmpty == false &&
        email.split(separator: "@").last?.isEmpty == false &&
        email.split(separator: ".").last?.isEmpty == false &&
        email.split(separator: ".").dropLast().last?.isEmpty == false
    }
}
