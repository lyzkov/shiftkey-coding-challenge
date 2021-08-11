//
//  Page.swift
//
//
//  Created by lyzkov on 27/07/2021.
//

import Foundation

import IdentifiedCollections

public struct Page<Item: Identifiable, Fault: Error, Index: Hashable>: Identifiable {
    public let index: Index
    public let items: Load<IdentifiedArrayOf<Item>, Fault>?

    public var id: Index {
        index
    }

    public var next: Page? {
        nil
    }

    public init(index: Index, items: Load<IdentifiedArrayOf<Item>, Fault>? = .none) {
        self.index = index
        self.items = items
    }

}

extension Page: Equatable where Item: Equatable, Fault: Equatable {
}

extension Page: ViewItem where Item: ViewItem, Fault: ViewError, Item.Core: Identifiable {

    public init(from corePage: Page<Item.Core, Fault.Core, Index>) {
        self.init(index: corePage.index, items: .init(from: corePage.items))
    }

}
