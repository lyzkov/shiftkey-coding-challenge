//
//  ViewItem.swift
//  CodingChallenge
//
//  Created by lyzkov on 17/06/2021.
//

import Foundation

import SwiftUI

import ComposableArchitecture

public protocol ViewItem: Equatable {
    associatedtype Core

    init(from core: Core)
}

public protocol ViewError: ViewItem, Error where Core: Error {
}

extension Result: ViewItem where Success: ViewItem, Failure: ViewError {
    public typealias Core = Result<Success.Core, Failure.Core>

    public init(from coreResult: Core) {
        self = coreResult
            .map(Success.init(from:))
            .mapError(Failure.init(from:))
    }

}

extension Status: ViewItem where Completed: ViewItem {

    public init(from coreStatus: Status<Completed.Core>) {
        self = coreStatus.map(Completed.init(from:))
    }

}

extension Optional: ViewItem where Wrapped: ViewItem {

    public init(from coreOptional: Wrapped.Core?) {
        self = coreOptional.map(Wrapped.init(from:))
    }

}

extension IdentifiedArrayOf: ViewItem
    where Element: ViewItem & Identifiable, ID == Element.ID, Element.Core: Identifiable {

    public init(from coreArray: IdentifiedArrayOf<Element.Core>) {
        self.init(uniqueElements: coreArray.map(Element.init(from:)))
    }

}
