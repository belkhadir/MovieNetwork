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
    var httpBody: [String: Any] { get }
    var urlParameters: [String: String?] { get }
    var requestType: RequestType { get }
}

// MARK: - Default values, some request doesn't require `params`, `urlParams` and `headers`
extension Requestable {
    var host: String {
        "api.themoviedb.org"
    }
    
    var httpBody: [String: Any] {
        [:]
    }
    
    var urlParameters: [String: String?] {
        [:]
    }
    
    var headers: [String: String] {
        [:]
    }
}

extension Requestable {
    func createURLRequest(bearerTokonize: BearTokenize) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = "/4" + path
        
        if !urlParameters.isEmpty {
            components.queryItems = urlParameters.map {
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

        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue(bearerTokonize.bearer, forHTTPHeaderField: "Authorization")
        if !httpBody.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: httpBody)
        }
        return urlRequest
    }
}
