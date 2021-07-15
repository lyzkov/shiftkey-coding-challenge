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
    
    public typealias State = Status<Result<Shift, ShiftsError>>

    public enum Action {
        case load(id: Shift.ID)
        case show(State)
        case unload
    }
    
    public typealias Environment = Main.Environment

    public static var reducer: Details.Reducer {
        .init { state, action, environment in
            struct LoadDetailsId: Hashable {}
            switch action {
            case .load(let id):
                return environment.pool.shift(id: id)
                    .map(Action.show)
                    .eraseToEffect()
                    .cancellable(id: LoadDetailsId(), cancelInFlight: true)
            case .unload:
                state = .idle
                return .cancel(id: LoadDetailsId())
            case .show(let status):
                state = status
            }
            
            return .none
        }
    }
    
}
