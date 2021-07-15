//
//  LoadableState.swift
//  CodingChallange
//
//  Created by lyzkov on 24/06/2021.
//

import Foundation

import CasePaths

public enum Status<Completed> {
    public typealias ProgressRatio = Float
    case idle // TODO: Remove in favor of nil
    case pending(ProgressRatio? = nil)
    case completed(Completed)
    
    @inlinable public func map<NewCompleted>(
        _ transform: (Completed) -> NewCompleted
    ) -> Status<NewCompleted> {
        switch self {
        case .idle:
            return .idle
        case .pending(let progress):
            return .pending(progress)
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

extension Status {
    
    @inlinable public func map<Success, Failure, NewSuccess>(
        _ transform: (Success) -> NewSuccess
    ) -> Status<Result<NewSuccess, Failure>> where Completed == Result<Success, Failure> {
        map { $0.map(transform) }
    }
    
    public static func completed<Success, Failure>(
        from success: Success
    ) -> Self where Completed == Result<Success, Failure> {
        .completed(.success(success))
    }
    
}

extension Status: Viewable where Completed: Viewable {
    
    public init(from entity: Status<Completed.Core>) {
        self = entity.map(Completed.init(from:))
    }
    
}
