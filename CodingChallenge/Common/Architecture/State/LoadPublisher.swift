//
//  LoadPublisher.swift
//
//  Created by lyzkov on 27/07/2021.
//

import Foundation
import Combine

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
