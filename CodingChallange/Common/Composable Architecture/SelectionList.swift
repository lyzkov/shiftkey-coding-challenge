//
//  SelectionList.swift
//  CodingChallange
//
//  Created by lyzkov on 24/06/2021.
//

import Foundation

protocol SelectiveList: Equatable {
    associatedtype Item: Equatable, Identifiable
    
    var items: [Item] { get }
    var selected: Item? { get }
}

struct SelectionList<Item: Equatable & Identifiable>: SelectiveList {
    
    let items: [Item]
    var selected: Item?
}

extension SelectionList {
    
    init(items: [Item]) {
        self.items = items
        selected = nil
    }
    
}

extension LoadableState where Item: SelectiveList {
    
    var items: [Item.Item]? {
        return item?.items
    }
    
    var selected: Item.Item? {
        return item?.selected
    }
    
}
