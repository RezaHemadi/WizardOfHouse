//
//  WTNetworkLayer.swift
//  WizardOfHouse
//
//  Created by Reza on 7/19/24.
//

import Foundation
import Combine

class WTNetworkLayer {
    // MARK: - Properties
    private let baseURL: URL
    
    // MARK: - Initialization
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    // MARK: - Methods
    func post(node: String?, headers: [String: Any], body: Data) -> AnyPublisher<Data, WTNetworkLayerError> {
        var url = baseURL
        if let node = node {
            url.append(path: node)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post.rawValue
        for (key, value) in headers {
            request.setValue(String(describing: value), forHTTPHeaderField: key)
        }
        
        request.httpBody = body
        
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .retry(3)
            .tryMap { receivedValue in
                
                let receivedPlainText = String(data: receivedValue.data, encoding: .utf8)
                print(receivedPlainText!)
                
                guard let httpResponse = receivedValue.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw WTNetworkLayerError.badServerResponse
                }
                
                guard receivedValue.data.count > 0 else { throw WTNetworkLayerError.zeroByteResource }
                
                return receivedValue.data
            }
            .mapError { error -> WTNetworkLayerError in
                print(error.localizedDescription)
                if let clientError = error as? WTNetworkLayerError {
                    return clientError
                } else {
                    return WTNetworkLayerError.custom(error.localizedDescription)
                }
                
            }
            .eraseToAnyPublisher()
        
        return publisher
    }
}

extension WTNetworkLayer {
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}

enum WTNetworkLayerError: Error {
    case noConnection
    case badServerResponse
    case zeroByteResource
    case custom(String)
}
