//
//  LoadableState.swift
//  CodingChallenge
//
//  Created by lyzkov on 24/06/2021.
//

import Foundation

import CasePaths

public enum Status<Completed> {
    public typealias ProgressRatio = Float
    
    case pending(ProgressRatio? = nil)
    case completed(Completed)
    
    @inlinable public func map<NewCompleted>(
        _ transform: (Completed) -> NewCompleted
    ) -> Status<NewCompleted> {
        switch self {
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
        map { completed in completed.map(transform) }
    }
    
    @inlinable public func compactMap<Success, Failure, NewSuccess>(
        replaceNil failure: Failure,
        transform: (Success) -> NewSuccess?
    ) -> Status<Result<NewSuccess, Failure>> where Completed == Result<Success, Failure> {
        map { (completed: Completed) in
            do {
                if let newSuccess = transform(try completed.get()) {
                    return .success(newSuccess)
                } else {
                    return .failure(failure)
                }
            } catch let error as Failure {
                return .failure(error)
            } catch _ {
                return .failure(failure)
            }
        }
    }
    
    @inlinable public func mapError<Success, Failure, NewFailure>(
        _ transform: (Failure) -> NewFailure
    ) -> Status<Result<Success, NewFailure>> where Completed == Result<Success, Failure> {
        map { completed in completed.mapError(transform) }
    }
    
    public static func completed<Success, Failure>(
        from success: Success
    ) -> Self where Completed == Result<Success, Failure> {
        .completed(.success(success))
    }
    
}
