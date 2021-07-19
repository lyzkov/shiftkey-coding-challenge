//
//  Reducer+Root.swift
//  
//
//  Created by lyzkov on 02/07/2021.
//

import Foundation

import ComposableArchitecture

extension Reducer where State: Resolvable, Action: Resolvable, Environment: Resolvable {
    
    func pullbackToRoot() -> Reducer<RootState, RootAction, RootEnvironment> {
        .init { state, action, environment in
            guard var subState: State = state.resolve(),
                  let subAction: Action = (/RootAction.node)
                    .extract(from: action),
                  let subEnvironment: Environment = environment.resolve()
            else {
                return .none
            }
            defer {
                state.set(subState)
            }
            
            return run(&subState, subAction, subEnvironment)
                .map(RootAction.node)
        }
    }
    
}

extension Store where State == RootState, Action == RootAction {
    
    func subscope<State: Resolvable, Action: Resolvable>() -> Store<State, Action> {
        scope(state: { $0.resolve() ?? .init() }, action: RootAction.node)
    }
    
}

extension Reducer {
    
    func receive(on scheduler: AnySchedulerOf<DispatchQueue>) -> Self {
        Self { state, action, environment in
            self(&state, action, environment)
                .receive(on: scheduler)
                .eraseToEffect()
        }
    }
    
}
