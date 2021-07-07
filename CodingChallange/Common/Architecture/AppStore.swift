//
//  AppStore.swift
//  
//
//  Created by lyzkov on 02/07/2021.
//

import Foundation

import ComposableArchitecture

typealias AppStore = Store<AppState, AppAction>

struct AppState: Resolving {
    var nodes: [String: Resolvable] = [:]
}

enum AppAction {
    case main(MainAction)
}

struct AppEnvironment: Resolving {
    var nodes: [String: Resolvable] = [:]
}
