//
//  Reducer+Effectless.swift
//  CodingChallange
//
//  Created by lyzkov on 23/06/2021.
//

import Foundation

import ComposableArchitecture

extension Reducer {
    
    static func effectless(
        _ reducer: @escaping (inout State, Action, Environment) -> Void
    ) -> Self {
        return .init { state, action, environment in
            reducer(&state, action, environment)
            return .none
        }
    }
    
}
