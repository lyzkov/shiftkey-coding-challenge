//
//  Viewable.swift
//  CodingChallange
//
//  Created by lyzkov on 17/06/2021.
//

import Foundation

public protocol Viewable {
    associatedtype Entity: Identifiable
    
    init(from entity: Entity)
}

public protocol ViewableState: Equatable {
    associatedtype CoreState
    
    init(from coreState: CoreState)
}

public protocol ViewableAction: Equatable {
    associatedtype CoreAction
    
    var coreAction: CoreAction { get }
}
