//
//  Reducer+Root.swift
//  
//
//  Created by lyzkov on 02/07/2021.
//

import Foundation

import ComposableArchitecture

extension Reducer where State: MainState, Action: MainAction, Environment: MainEnvironemnt {
    
    func pullbackToRoot() -> Reducer<AppState, AppAction, AppEnvironment> {
        .init { state, action, environment in
            guard var subState: State = state.resolve(),
                  let subAction: Action = (/AppAction.main)
                    .extract(from: action),
                  let subEnvironment: Environment = environment.resolve()
            else {
                return .none
            }
            defer {
                state.set(subState)
            }
            
            return run(&subState, subAction, subEnvironment)
                .map(AppAction.main)
        }
    }
    
}

extension Store where State == AppState, Action == AppAction {
    
    func subscope<LocalState: MainState, LocalAction: MainAction>() -> Store<LocalState, LocalAction> {
        scope(state: { $0.resolve() ?? .init() }, action: AppAction.main)
    }
    
}
