//
//  AuthenticationService.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Vapor

final class AuthenticationService { }

extension AuthenticationService: AuthenticationServiceProtocol {
    func hash(password: String?) -> String? {
        guard let password = password, isValid(password: password) else { return nil }
        return try? Bcrypt.hash(password)
    }

    func isValid(password: String?, hashedPassword: String) -> Bool {
        guard let password = password else { return false }
        return (try? Bcrypt.verify(password, created: hashedPassword)) == true
    }

    func isValid(email: String) -> Bool {
        email.contains("@") &&
        email.firstIndex(of: "@") == email.lastIndex(of: "@") &&
        email.split(separator: "@").first?.isEmpty == false &&
        email.split(separator: "@").last?.isEmpty == false &&
        email.split(separator: ".").last?.isEmpty == false &&
        email.split(separator: ".").dropLast().last?.isEmpty == false
    }
}

extension AuthenticationService {
    private func isValid(password: String) -> Bool {
        let lowerCaseSet = NSCharacterSet.lowercaseLetters
        let upperCaseSet = NSCharacterSet.uppercaseLetters
        let decimalSet = CharacterSet.decimalDigits

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
