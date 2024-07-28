//
//  GPTMessage.swift
//  WizardOfHouse
//
//  Created by Reza on 7/26/24.
//

import Foundation

struct GPTMessage: Codable {
    let content: String
    let role: Role
}

extension GPTMessage {
    enum Role: String, Codable {
        case system
        case user
        case assistant
    }
}
