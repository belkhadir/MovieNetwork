//
//  Requestable.swift
//  
//
//  Created by Belkhadir Anas on 5/10/23.
//

import Foundation

public protocol Requestable {
    var path: String { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?] { get }
    var bearToken: String { get }
    var requestType: RequestType { get }
}

// MARK: - Default values, some request doesn't require `params`, `urlParams` and `headers`
extension Requestable {
    var host: String {
        "api.themoviedb.org"
    }
    
    var params: [String: Any] {
        [:]
    }
    
    var urlParams: [String: String?] {
        [:]
    }
    
    var headers: [String: String] {
        [:]
    }
}

extension Requestable {
    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/4" + path
        
        if !urlParams.isEmpty {
            components.queryItems = urlParams.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
          
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        return urlRequest
    }
}
