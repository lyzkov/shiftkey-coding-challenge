//
//  LoadableState.swift
//  CodingChallange
//
//  Created by lyzkov on 24/06/2021.
//

import Foundation

import CasePaths

enum LoadableState<Item: Equatable, Error: Swift.Error & Equatable>: Equatable {
    case loading
    case completed(Item)
    case failed(Error)
    
    var isLoading: Bool {
        return self == .loading
    }
    
    var item: Item? {
        return (/Self.completed).extract(from: self)
    }
    
    var error: Error? {
        return (/Self.failed).extract(from: self)
    }
    
}
