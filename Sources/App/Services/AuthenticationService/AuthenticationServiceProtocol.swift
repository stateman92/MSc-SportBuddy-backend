//
//  AuthenticationServiceProtocol.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Foundation

protocol AuthenticationServiceProtocol: Initable, AutoMockable {
    /// Hash a password.
    /// - Parameter password: the plain text password.
    /// - Returns: The hashed password.
    func hash(password: String?) -> String?

    /// Check if the given password is correct based on the hashed password.
    /// - Parameter password: the plain text password.
    /// - Parameter hashedPassword: the hashed password.
    /// - Returns: Whether the password is correct.
    func isValid(password: String?, hashedPassword: String) -> Bool

    /// Check if the given email is valid.
    /// - Parameter email: the email.
    /// - Returns: Whether the email is valid.
    /// - Note: A `true` return value doesn't mean that the email is indeed exists.
    func isValid(email: String) -> Bool
}

extension AuthenticationServiceProtocol {
    /// Check if the given password is valid.
    /// - Parameter password: the password.
    /// - Returns: Whether the password is valid.
    /// - Note: A `true` return value doesn't mean that the password is unbreakable.
    func isValid(password: String) -> Bool {
        let lowerCaseSet: CharacterSet = .lowercaseLetters
        let upperCaseSet: CharacterSet = .uppercaseLetters
        let decimalSet: CharacterSet = .decimalDigits

        var lowerCaseCharater = false
        var upperCaseCharater = false
        var decimalCharater = false
        password.utf16.forEach {
            guard let character = Unicode.Scalar($0) else { return }
            if lowerCaseSet.contains(character) {
                lowerCaseCharater = true
            } else if upperCaseSet.contains(character) {
                upperCaseCharater = true
            } else if decimalSet.contains(character) {
                decimalCharater = true
            }
        }
        return password.count > 7 && upperCaseCharater && lowerCaseCharater && decimalCharater
    }
}
