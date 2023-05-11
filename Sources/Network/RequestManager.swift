//
//  RequestManager.swift
//  
//
//  Created by Belkhadir Anas on 5/10/23.
//

import Foundation

public protocol RequestManaging {
    func perform<T: Decodable>(request: Requestable, bearTokenize: BearTokenize) async throws -> T
}

final public class RequestManager {
    private let service: NetworkServiceProviding
    private let parser: Parsing
    
    init(service: NetworkServiceProviding = NetworkServiceProvider(),
         parser: Parsing = Parser()
    ) {
        self.service = service
        self.parser = parser
    }
}

// MARK: - RequestManaging
extension RequestManager: RequestManaging {
    public func perform<T>(request: Requestable, bearTokenize: BearTokenize) async throws -> T where T : Decodable {
        let data = try await service.perform(request: request, bearTokenize: bearTokenize)
        return try parser.parse(data: data)
    }
}
