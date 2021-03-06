//
//  Constants.swift
//  
//
//  Created by Kristof Kalai on 2022. 03. 14..
//

import Foundation
import Gatekeeper

enum Constants {
    enum Schema: String, CaseIterable {
        case users
        case exercises
        case chats
        case chatEntries
        case groups
        case groupEntries
    }

    enum EnvironmentKey: String {
        case hostname
        case username
        case password
        case database
        case sendgrid

        var key: String {
            switch self {
            case .sendgrid: return "SENDGRID_API_KEY"
            default: return rawValue.uppercased()
            }
        }
    }

    static let tokenValidityInterval: TimeInterval = 5 * 60

    static let gatekeeperConfig: GatekeeperConfig = .init(maxRequests: 5, per: .second)
}
