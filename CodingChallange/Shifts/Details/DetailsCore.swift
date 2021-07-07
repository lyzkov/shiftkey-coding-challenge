//
//  ShiftDetailsCore.swift
//  CodingChallange
//
//  Created by lyzkov on 23/06/2021.
//

import Foundation

import Common

import ComposableArchitecture

enum Details {
    
    typealias State = LoadableState<Shift, Never>

    enum Action {
        case load(id: Shift.ID)
        case show(shift: Shift)
    }
    
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Main.Environment>

    static let reducer = Reducer
        .effectless { state, action, environment in
            switch (action, state) {
            case (.show(let shift), .loading):
                state = .completed(shift)
            default:
                break
            }
        }
    
}
