//
//  ShiftDetailsCore.swift
//  CodingChallange
//
//  Created by lyzkov on 23/06/2021.
//

import Foundation

import ComposableArchitecture

enum Details {
    
    typealias State = LoadableState<Shift, Main.Error>

    enum Action {
        case load(id: Shift.ID)
        case show(shift: Shift)
    }
    
    typealias Reducer = ComposableArchitecture.Reducer<State?, Action, Main.Environment>

    static let reducer = Reducer
        .effectless { state, action, environment in
            switch (action, state) {
            case (.show(let shift), .loading):
                state = .completed(shift)
            default:
                break
            }
        }
        .pullback(state: \Main.State.details, action: /Main.Action.details, environment: { $0 })
    
}
