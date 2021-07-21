//
//  File.swift
//  
//
//  Created by lyzkov on 21/07/2021.
//

import Foundation
import Combine

public class Client {
    
    let decoder: JSONDecoder
    
    // TODO: downloading progress
    public func decoded<Core: Entity>(from request: URLRequest) -> AnyPublisher<Core, Error> {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Core.Raw.self, decoder: decoder)
            .map(Core.init(from:))
            .eraseToAnyPublisher()
    }
    
    public func decoded<Core: Entity>(from request: URLRequest) -> AnyPublisher<Status<Result<Core, Error>>, Never> {
        decoded(from: request)
            .map(Result.success)
            .map(Status.completed)
            .catch { error in
                Just(.completed(.failure(error)))
            }
            .eraseToAnyPublisher()
    }
    
    public init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
}
