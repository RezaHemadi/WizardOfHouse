//
//  GPTClient.swift
//  WizardOfHouse
//
//  Created by Reza on 7/19/24.
//

import Foundation
import Combine

class GPTClient {
    // MARK: - Properties
    private let apiURL = URL(string: "https://api.openai.com/v1/chat/completions")
    private let apiKey: String = "sk-None-EG8QyL1LGVAN67a50WL5T3BlbkFJ5U76Y4qq7w5viAAQcU6e"
    private var decoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        return jsonDecoder
    }
    private var streams: Set<AnyCancellable>
    
    // MARK: - Initialization
    init() {
        self.streams = Set<AnyCancellable>()
    }
    
    // MARK: - Methods
    func completion(for messages: [GPTMessage], configuration: GPTChatCompletionConfiguration = .init()) -> AnyPublisher<String, any Error> {
        let client = WTNetworkLayer(baseURL: URL(string: "https://api.openai.com")!)
        let headers = ["Authorization":"Bearer \(apiKey)",
                       "Content-Type": "application/json"]
        let request = GPTRequest(model: .gpt4o,
                                 messages: messages,
                                 configuration: configuration)
        let requestData = try! JSONEncoder().encode(request)
        let publisher = client.post(node: "v1/chat/completions", headers: headers, body: requestData)
            .decode(type: GPTResponse.self, decoder: decoder)
            .compactMap{ $0.choices.first?.message.content }
            .eraseToAnyPublisher()
        
        return publisher
    }
}
