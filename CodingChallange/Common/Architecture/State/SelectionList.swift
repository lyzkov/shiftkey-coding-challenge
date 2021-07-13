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
    public let items: [Item] // TODO: IdentifiedArrayOf
    public var selected: Item?
    public init(items: [Item], selected: Item? = nil) {
        self.items = items
        self.selected = selected
    }
}

extension SelectionList: Viewable where Item: Viewable, Item.Core: Equatable & Identifiable {
    
    public init(from entity: SelectionList<Item.Core>) {
        self.init(
            items: entity.items.map(Item.init(from:)),
            selected: entity.selected.map(Item.init(from:))
        )
    }
    
}

extension Status where Completed: SelectiveList {
    
    public var items: [Completed.Item]? {
        return map(\.items).get()
    }
    
    public var selected: Completed.Item?? {
        return map(\.selected).get()
    }
    
}
