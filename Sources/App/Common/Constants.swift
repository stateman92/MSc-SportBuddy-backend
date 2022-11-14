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
        case exerciseModels
        case chats
        case chatEntries
    }

    enum EnvironmentKey: String {
        case hostname
        case username
        case password
        case database
        case sendgrid
        case sendgridEmail
        case mailgunDomain
        case mailgunEmail
        case replyEmail
        case tls

        var key: String {
            switch self {
            case .sendgrid: return "SENDGRID_API_KEY"
            default: return rawValue.uppercased()
            }
        }
    }

    static let version = "1.0.17"
    static let tokenValidityInterval: TimeInterval = .minutes(30)
    private static let resetTokenValidityMinutes = 60
    static let resetTokenValidityInterval: TimeInterval = .minutes(resetTokenValidityMinutes)

    static let gatekeeperConfig: GatekeeperConfig = .init(maxRequests: 5, per: .second)

    static func forgotPasswordEmail(name: String, email: String, token: String) -> (subject: String, text: String) {
        let url = "https://sportbuddyweb.herokuapp.com/resetPassword?token="
        let content =
"""
<!DOCTYPE html>
<html>
<head>
</head>
<body>

<h2>Hello {{name}},</h2>
We've received a request to reset the password for the SportBuddy account associated with <strong>{{email}}</strong>. No changes have been made to your account so far.
<br/>
<br/>
You can reset your password by clicking the button below:
<br/>
<br/>
<button style="border-radius: 12px;padding: 8px 16px;font-size: 18px;background-color: navy;color: white;border: none;">
<a href="{{url}}{{token}}"
   target="_blank"
   rel="noopener"
   style="text-decoration: none;color: inherit;">
   <b>Reset your password</b>
</a>
</button>
<br/>
<br/>
Or if the button doesn't work, you can access the address manually:
<a href="{{url}}{{token}}" target="_blank" rel="noopener"><i>{{url}}{{token}}</i></a>
<p>Note: You have no more than <b>{{minutes}} minutes</b> to change your password. After that you'll have to request another change.
<br/>
<br/>
In case of you didn't ask for a new password, you can safely ignore this email.
<br/>
<br/>
Have a great day!
<br/>
&mdash; <i>your SportBuddy team</i>

</body>
</html>
"""
            .replacingOccurrences(of: "{{name}}", with: name)
            .replacingOccurrences(of: "{{email}}", with: email)
            .replacingOccurrences(of: "{{token}}", with: token)
            .replacingOccurrences(of: "{{url}}", with: url)
            .replacingOccurrences(of: "{{minutes}}", with: String(Int(resetTokenValidityMinutes)))
        assert(!content.contains("{{") && !content.contains("}}"))
        let subject = "Forgot your SportBuddy password?"
        return (subject, content)
    }
}
