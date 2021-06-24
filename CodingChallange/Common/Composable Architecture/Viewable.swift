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

protocol ViewableState: Equatable {
    associatedtype CoreState
    
    init(from coreState: CoreState)
}

protocol ViewableAction: Equatable {
    associatedtype CoreAction
    
    var coreAction: CoreAction { get }
}

@propertyWrapper
struct ViewStore<ViewState: ViewableState, ViewAction: ViewableAction> {
    typealias CoreState = ViewState.CoreState
    typealias CoreAction = ViewAction.CoreAction
    
    var wrappedValue: Store<ViewState, ViewAction>
    
    init() {
        self.init(state: { $0 }, action: { $0 })
    }
    
    init<State, Action>
        (state: @escaping (State) -> CoreState,
         action: @escaping (CoreAction) -> Action) {
        let coreStore: Store<State, Action> = DependencyContainer.resolve()
        wrappedValue = coreStore
            .scope(state: state, action: action)
            .scope(state: ViewState.init(from:), action: { $0.coreAction })
    }
    
}
