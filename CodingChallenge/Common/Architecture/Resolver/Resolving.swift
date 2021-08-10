//
//  Resolving.swift
//  
//
//  Created by lyzkov on 02/07/2021.
//

import Foundation

protocol Resolving {
    var nodes: [String: Resolvable] { get set }
}

extension Resolving {

    func resolve<Node: Resolvable>() -> Node? {
        nodes[Node.typeId] as? Node
    }

    mutating func register<Node: Resolvable>(_ type: Node.Type) {
        set(Node())
    }

    mutating func set<Node: Resolvable>(_ node: Node) {
        nodes[Node.typeId] = node
    }

}
