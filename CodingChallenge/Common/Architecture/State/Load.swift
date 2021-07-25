//
//  Load.swift
//  
//
//  Created by lyzkov on 16/07/2021.
//

import Foundation
import Combine

public typealias Load<Item, Fault: Error> = Status<Result<Item, Fault>>

extension Status {
    
    public static func success<Item, Fault>(
        _ success: Item
    ) -> Self where Completed == Result<Item, Fault> {
        .completed(.success(success))
    }
    
    public static func failure<Item, Fault>(
        _ failure: Fault
    ) -> Self where Completed == Result<Item, Fault> {
        .completed(.failure(failure))
    }
    
    @inlinable public func map<Item, Fault, Transformed>(
        _ transform: (Item) throws -> Transformed
    ) rethrows -> Load<Transformed, Fault>
    where Completed == Result<Item, Fault> {
        try map { (completed: Completed) in
            switch completed {
            case .success(let success):
                return .success(try transform(success))
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    @inlinable public func mapError<Item, Fault, TransformedFault>(
        _ transform: (Fault) -> TransformedFault
    ) -> Load<Item, TransformedFault>
    where Completed == Result<Item, Fault> {
        map { completed in completed.mapError(transform) }
    }
    
}

public typealias LoadPublisher<Item, Fault: Error> = AnyPublisher<Load<Item, Fault>, Never>

public extension Publisher where Failure == Never {
    
    func decode<Item: Decodable, Coder: TopLevelDecoder>(
        type: Item.Type,
        decoder: Coder
    ) -> Publishers.Map<Self, Load<Item, Error>>
    where Output == Load<Data, Error>, Coder.Input == Data {
        mapItem { data in
            try decoder.decode(type, from: data)
        }
    }
    
    func mapItem<Item, Transformed>(
        _ transform: @escaping (Item) throws -> Transformed
    ) -> Publishers.Map<Self, Load<Transformed, Error>>
    where Output == Load<Item, Error> {
        map { status in
            do {
                return try status.map(transform)
            } catch let error {
                return .failure(error)
            }
        }
    }
    
    func mapFault<Item, Fault: Error>(
        _ transform: @escaping (Error) -> Fault
    ) -> Publishers.Map<Self, Load<Item, Fault>>
    where Output == Load<Item, Error> {
        map { status in
            status.mapError(transform)
        }
    }
    
    func eraseToLoadPublisher<Item, Fault>(
    ) -> LoadPublisher<Item, Fault>
    where Output == Load<Item, Fault> {
        eraseToAnyPublisher()
    }
    
}
