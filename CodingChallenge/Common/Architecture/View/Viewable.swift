//
//  Viewable.swift
//  CodingChallenge
//
//  Created by lyzkov on 17/06/2021.
//

import Foundation

import SwiftUI

import IdentifiedCollections

public protocol Viewable: Equatable {
    associatedtype Core
    
    init(from core: Core)
}

public protocol ViewableError: Viewable, Error where Core: Error {
}

public protocol ComposableView: View {
    associatedtype State: Viewable
}


public protocol FakeView: ComposableView {
    static func fake(with state: State) -> Self
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
    
    public init(from coreOptional: Wrapped.Core?) {
        self = coreOptional.map(Wrapped.init(from:))
    }
    
}

extension Array: Viewable where Element: Viewable {
    
    public init(from coreArray: [Element.Core]) {
        self.init(coreArray.map(Element.init(from:)))
    }
}

extension IdentifiedArrayOf: Viewable
    where Element: Viewable & Identifiable, ID == Element.ID, Element.Core: Identifiable {
    
    public init(from coreArray: IdentifiedArrayOf<Element.Core>) {
        self.init(uniqueElements: coreArray.map(Element.init(from:)))
    }
}
