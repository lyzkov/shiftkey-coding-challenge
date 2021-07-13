//
//  LoadableState.swift
//  CodingChallange
//
//  Created by lyzkov on 24/06/2021.
//

import Foundation

import CasePaths

public enum Status<Completed> {
    case idle
    case pending(Ratio? = nil)
    case completed(Completed)
    
    @inlinable public func map<NewCompleted>(
        _ transform: (Completed) -> NewCompleted
    ) -> Status<NewCompleted> {
        switch self {
        case .idle:
            return .idle
        case .pending(let ratio):
            return .pending(ratio)
        case .completed(let completed):
            return .completed(transform(completed))
        }
    }
    
    @inlinable public func get() -> Completed? {
        (/Self.completed).extract(from: self)
    }

}

extension Status: Equatable where Completed: Equatable {
}

public struct Ratio: ExpressibleByFloatLiteral, Equatable {
    public let value: Float
    
    public init(floatLiteral value: Float) {
        precondition((0...1.0).contains(value),
            "Value of ratio out of 0...1.0 bounds."
        )
        self.value = value
    }
    
}

extension Status: Viewable where Completed: Viewable {
    
    public init(from entity: Status<Completed.Core>) {
        self = entity.map(Completed.init(from:))
    }
    
}
