//
//  Viewable.swift
//  CodingChallange
//
//  Created by lyzkov on 17/06/2021.
//

import Foundation

import ComposableArchitecture

protocol Viewable {
    associatedtype Entity: Identifiable
    
    init(from entity: Entity)
}

@propertyWrapper struct ViewableStore<ViewState: ViewableState, Action> {
    typealias CoreState = ViewState.CoreState
    
    var wrappedValue: Store<CoreState, Action>
    var projectedValue: Store<ViewState, Action>
    
    init(wrappedValue: Store<CoreState, Action>) {
        self.wrappedValue = wrappedValue
        projectedValue = wrappedValue.scope { state in ViewState(from: state)}
    }
    
}

protocol ViewableState: Equatable {
    associatedtype CoreState
    
    init(from coreState: CoreState)
}
