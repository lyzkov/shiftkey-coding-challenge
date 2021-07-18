//
//  Viewable.swift
//  CodingChallange
//
//  Created by lyzkov on 17/06/2021.
//

import Foundation

import SwiftUI

public protocol Viewable: Equatable {
    associatedtype Core
    
    init(from core: Core)
}

public protocol ViewableError: Viewable, Error where Core: Error {
}

public protocol ComposableView: View {
    associatedtype State: Viewable
}

extension Result: Viewable where Success: Viewable, Failure: ViewableError {
    public typealias Core = Result<Success.Core, Failure.Core>
    
    public init(from coreResult: Core) {
        switch coreResult {
        case .success(let success):
            self = .success(.init(from: success))
        case .failure(let failure):
            self = .failure(.init(from: failure))
        }
    }

}

extension Result where Success: Viewable, Failure: Equatable {
    
    public init(from coreResult: Result<Success.Core, Failure>) {
        self = coreResult.map(Success.init(from:))
    }
}

extension Status: Viewable where Completed: Viewable {
    
    public init(from coreStatus: Status<Completed.Core>) {
        self = coreStatus.map(Completed.init(from:))
    }
    
}

extension Optional: Viewable where Wrapped: Viewable {
    public typealias Core = Wrapped.Core?
    
    public init(from coreOptional: Wrapped.Core?) {
        self = coreOptional.map(Wrapped.init(from:))
    }
    
}

extension Array: Viewable where Element: Viewable {
    public typealias Core = [Element.Core]
    
    public init(from coreArray: [Element.Core]) {
        self.init(coreArray.map(Element.init(from:)))
    }
}
