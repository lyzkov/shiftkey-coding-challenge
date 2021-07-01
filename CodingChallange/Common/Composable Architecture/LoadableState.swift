//
//  LoadableState.swift
//  CodingChallange
//
//  Created by lyzkov on 24/06/2021.
//

import Foundation

import CasePaths

public enum LoadableState<Item: Equatable, Error: Swift.Error & Equatable>: Equatable {
    case idle
    case loading
    case completed(Item)
    case failed(Error)
    
    public var isLoading: Bool {
        return self == .loading
    }
    
    public var item: Item? {
        return (/Self.completed).extract(from: self)
    }
    
    public var error: Error? {
        return (/Self.failed).extract(from: self)
    }
    
}
