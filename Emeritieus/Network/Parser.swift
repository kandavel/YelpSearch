//
//  Parser.swift
//  CitySquare
//
//  Created by ELDHOSE LOMY on 22/06/21.
//

import Foundation

protocol ParserProtocol {
    func json<T: Codable>(data: Data, completition: @escaping (ResultCallback<T>) -> Void)
}

struct Parser {
   private let jsonDecoder = JSONDecoder()
    
    func json<T: Codable>(data: Data, completition: @escaping (ResultCallback<T>) -> Void) {
        do {
            let result: T = try jsonDecoder.decode(T.self, from: data)
            OperationQueue.main.addOperation { completition(.success(result)) }
            
        } catch let error {
            OperationQueue.main.addOperation { completition(.failure(.parserError(error: error))) }
        }
    }
}
