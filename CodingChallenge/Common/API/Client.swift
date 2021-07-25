//
//  File.swift
//  
//
//  Created by lyzkov on 21/07/2021.
//

import Foundation

public class Client {
    
    private let session: URLSession
    
    private let decoder: JSONDecoder
    
    public init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    public func decoded<Core: Entity>(
        from request: URLRequest
    ) -> LoadPublisher<Core, Error> {
        session.dataTaskLoadPublisher(for: request)
            .decode(type: Core.Raw.self, decoder: decoder)
            .mapItem(Core.init(from:))
            .eraseToLoadPublisher()
    }
    
}
