//
//  GPTResponse.swift
//  WizardOfHouse
//
//  Created by Reza on 7/26/24.
//

import Foundation

struct GPTResponse: Decodable {
    let created: Date
    let id: String
    let choices: [Choice]
    
    enum CodingKeys: String, CodingKey {
        case created
        case id
        case choices
    }
}

extension GPTResponse {
    struct Choice: Decodable {
        let index: Int
        let message: GPTMessage
    }
}
