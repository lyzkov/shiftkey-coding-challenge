//
//  ViewStoreProvider.swift
//  
//
//  Created by lyzkov on 08/07/2021.
//

import Foundation

import ComposableArchitecture

public protocol ViewStoreProvider {
    associatedtype Module: Common.Module
    typealias State = Module.State
    typealias Action = Module.Action

    static var viewStore: ViewStore<State, Action> { get }
}

extension ViewStoreProvider {

    public static var viewStore: ViewStore<State, Action> {
        return ViewStore(StoreResolver.shared.resolve())
    }

}
