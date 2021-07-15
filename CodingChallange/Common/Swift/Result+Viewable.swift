//
//  File.swift
//  
//
//  Created by lyzkov on 13/07/2021.
//

import Foundation

extension Result: Viewable where Success: Viewable, Failure: ViewableError {
    public typealias Core = Result<Success.Core, Failure.Core>
    public init(from entity: Result<Success.Core, Failure.Core>) {
        switch entity {
        case .success(let value):
            self = .success(.init(from: value))
        case .failure(let error):
            self = .failure(.init(from: error))
        }
    }

}

extension Result where Success: Viewable, Failure: Equatable {
    
    public init(from entity: Result<Success.Core, Failure>) {
        self = entity.map(Success.init(from:))
    }
}
