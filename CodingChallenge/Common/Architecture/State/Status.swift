//
//  Status.swift
//  CodingChallenge
//
//  Created by lyzkov on 24/06/2021.
//

import Foundation

import CasePaths

public enum Status<Completed> {
    case pending(Fraction? = nil)
    case completed(Completed)
    
    public typealias Fraction = Float
}

extension Status {
    
    @inlinable public func map<Transformed>(
        _ transform: (Completed) throws -> Transformed
    ) rethrows -> Status<Transformed> {
        switch self {
        case .pending(let progress):
            return .pending(progress)
        case .completed(let completed):
            return .completed(try transform(completed))
        }
    }
    
    @inlinable public func get() -> Completed? {
        (/Self.completed).extract(from: self)
    }
    
}

extension Status: Equatable where Completed: Equatable {
}
