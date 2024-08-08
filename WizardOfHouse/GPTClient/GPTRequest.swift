//
//  GPTRequest.swift
//  WizardOfHouse
//
//  Created by Reza on 7/26/24.
//

import Foundation

struct GPTRequest: Encodable {
    // MARK: - Properties
    let model: Model
    let messages: [GPTMessage]
    
    /// How many chat completion choices to generate for each input message.
    let n: Int
    
    /// The maximum number of tokens that can be generated in the chat completion.
    let maxTokens: Int?
    
    /// What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    var temperature: Double
    
    init(model: Model, messages: [GPTMessage], n: Int = 1, frequencyPenalty: Double = 0.0, maxTokens: Int? = nil, presencePenalty: Double = 0.0, temperature: Double = 1.0) {
        self.model = model
        self.messages = messages
        self.n = n
        self.maxTokens = maxTokens
        self.temperature = temperature
    }
    
    init(model: Model, messages: [GPTMessage], n: Int = 1, configuration: GPTChatCompletionConfiguration) {
        self.model = model
        self.messages = messages
        self.n = n
        self.maxTokens = configuration.maxTokens
        self.temperature = configuration.temperature
    }
}

extension GPTRequest {
    enum Model: String, Encodable {
        case gpt4o = "gpt-4o"
    }
}
