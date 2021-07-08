//
//  ShiftDetailsCore.swift
//  CodingChallange
//
//  Created by lyzkov on 23/06/2021.
//

import Foundation

import Common

import ComposableArchitecture

public enum Details: Core {
    
    public typealias State = LoadableState<Shift, Never>

    public enum Action {
        case load(id: Shift.ID)
        case show(shift: Shift)
    }
    
    public typealias Environment = Main.Environment

    public static var reducer: Details.Reducer {
        .effectless { state, action, environment in
            switch (action, state) {
            case (.show(let shift), .loading):
                state = .completed(shift)
            default:
                break
            }
        }
    }
    
}
