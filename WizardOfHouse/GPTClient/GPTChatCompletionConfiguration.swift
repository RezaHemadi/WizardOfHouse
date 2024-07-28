//
//  GPTChatCompletionConfiguration.swift
//  WizardOfHouse
//
//  Created by Reza on 7/26/24.
//

import Foundation

struct GPTChatCompletionConfiguration {
    let frequencyPenalty: Double
    let maxTokens: Int?
    let presencePenalty: Double
    let temperature: Double
    
    init(frequencyPenalty: Double = 0.0, maxTokens: Int? = nil, presencePenalty: Double = 0.0, temperature: Double = 1.0) {
        self.frequencyPenalty = frequencyPenalty
        self.maxTokens = maxTokens
        self.presencePenalty = presencePenalty
        self.temperature = temperature
    }
}
