//
//  SelectionList.swift
//  CodingChallange
//
//  Created by lyzkov on 24/06/2021.
//

import Foundation

public protocol SelectiveList: Equatable {
    associatedtype Item: Equatable, Identifiable
    
    var items: [Item] { get }
    var selected: Item? { get }
}

public struct SelectionList<Item: Equatable & Identifiable>: SelectiveList {
    public let items: [Item]
    public var selected: Item?
    public init(items: [Item], selected: Item? = nil) {
        self.items = items
        self.selected = selected
    }
}

extension LoadableState where Item: SelectiveList {
    
    public var items: [Item.Item]? {
        return item?.items
    }
    
    public var selected: Item.Item? {
        return item?.selected
    }
    
}
