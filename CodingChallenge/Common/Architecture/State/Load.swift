//
//  Load.swift
//  
//
//  Created by lyzkov on 16/07/2021.
//

import Foundation

public typealias Load<Item, Fault: Error> = Status<Result<Item, Fault>>

extension Status where Fraction == Double {

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

extension Optional {

    public func isEmpty<Item, S: Collection, Fault: Error>(
    ) -> Bool where Wrapped == Status<Result<S, Fault>>, S.Element == Item {
        guard case .some(.completed(.success(let items))) = self else {
            return true
        }

        return items.isEmpty
    }

}
