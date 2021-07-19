//
//  Root.swift
//  
//
//  Created by lyzkov on 02/07/2021.
//

import Foundation

import ComposableArchitecture

struct RootState: Resolving {
    var nodes: [String: Resolvable] = [:]
}

enum RootAction {
    case node(Resolvable)
}

struct RootEnvironment: Resolving {
    var nodes: [String: Resolvable] = [:]
}

typealias RootReducer = Reducer<RootState, RootAction, RootEnvironment>

typealias RootStore = Store<RootState, RootAction>
