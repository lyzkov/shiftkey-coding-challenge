//
//  ViewStoreProvider+Main.swift
//  
//
//  Created by lyzkov on 08/07/2021.
//

import Foundation

import Common

import ComposableArchitecture

extension ViewStoreProvider where State == Main.State, Action == Main.Action {

    public static var viewStore: ViewStore<State, Action> {
        Main.register()
        return ViewStore(StoreResolver.shared.resolve())
    }

}
