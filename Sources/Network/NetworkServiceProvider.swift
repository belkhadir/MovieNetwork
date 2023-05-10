//
//  NetworkServiceProvider.swift
//  
//
//  Created by Belkhadir Anas on 5/10/23.
//

import Foundation

public protocol NetworkServiceProviding {
    func perform(request: Requestable) async throws -> Data
}

final class NetworkServiceProvider {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - NetworkServiceProviding
extension NetworkServiceProvider: NetworkServiceProviding {
    func perform(request: Requestable) async throws -> Data {
        let request = try request.createURLRequest()
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.isOK else {
            throw NetworkError.invalidServerResponse
        }
        return data
    }
}
