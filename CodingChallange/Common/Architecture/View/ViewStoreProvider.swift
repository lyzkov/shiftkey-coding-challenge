//
//  ViewStoreProvider.swift
//  
//
//  Created by lyzkov on 08/07/2021.
//

import Foundation

import ComposableArchitecture

public protocol ViewStoreProvider {
    associatedtype M: Core, Module where M.State: BranchState, M.Action: BranchAction
    typealias State = M.State
    typealias Action = M.Action
    
    static var viewStore: ViewStore<State, Action> { get }
}

extension ViewStoreProvider {

    public static var viewStore: ViewStore<State, Action> {
        M.register()
        return ViewStore(StoreResolver.shared.resolve())
    }

}
