//
//  Parser.swift
//  
//
//  Created by Belkhadir Anas on 5/10/23.
//

import Foundation

public protocol Parsing {
    func parse<T: Decodable>(data: Data) throws -> T
}

final class Parser {
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
}

// MARK: - Parsing
extension Parser: Parsing {
    func parse<T>(data: Data) throws -> T where T : Decodable {
        try decoder.decode(T.self, from: data)
    }
}
