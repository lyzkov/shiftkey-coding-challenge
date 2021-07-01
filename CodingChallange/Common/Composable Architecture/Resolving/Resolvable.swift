//
//  Resolvable.swift
//  
//
//  Created by lyzkov on 02/07/2021.
//

import Foundation

public protocol Resolvable {
    init()
    static var typeId: String { get }
}

public extension Resolvable {
    
    static var typeId: String {
        String(describing: Self.self)
    }
    
}
