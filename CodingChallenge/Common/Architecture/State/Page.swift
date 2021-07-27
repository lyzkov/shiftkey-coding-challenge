//
//  Page.swift
//
//
//  Created by lyzkov on 27/07/2021.
//

import Foundation

import IdentifiedCollections

public struct Page<Index: Hashable, Item: Identifiable, Fault: Error>: Identifiable {
    public let index: Index
    public let items: Load<IdentifiedArrayOf<Item>, Fault>?
    
    public var id: Index {
        index
    }
    
    public var next: Page? {
        nil
    }
    
    public init(index: Index, items: Load<IdentifiedArrayOf<Item>, Fault>?) {
        self.index = index
        self.items = items
    }
    
}

extension Page: Equatable where Item: Equatable, Fault: Equatable {
}

extension Page: Viewable where Item: Viewable, Fault: ViewableError, Item.Core: Identifiable {
    
    public init(from corePage: Page<Index, Item.Core, Fault.Core>) {
        self.init(index: corePage.index, items: .init(from: corePage.items))
    }
    
}
