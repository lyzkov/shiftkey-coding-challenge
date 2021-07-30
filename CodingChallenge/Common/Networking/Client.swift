//
//  Client.swift
//  
//
//  Created by lyzkov on 21/07/2021.
//

import Foundation
import Combine

public class Client {
    
    private let session: URLSession
    
    private let decoder: JSONDecoder
    
    public init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    public func decoded<Core: Entity, Endpoint: Resource>(
        from endpoint: Endpoint
    ) -> LoadPublisher<Core, Error> where Endpoint.Raw == Core.Raw {
        do {
            return session.dataTaskLoadPublisher(for: try endpoint.asURLRequest())
                .decode(type: Core.Raw.self, decoder: decoder)
                .mapItem(Core.init(from:))
                .eraseToLoadPublisher()
        } catch let error {
            return Just(.failure(error)).eraseToLoadPublisher()
        }
        
    }
    
}
