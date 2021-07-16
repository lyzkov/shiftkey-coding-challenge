//
//  ShiftDetailsCore.swift
//  CodingChallange
//
//  Created by lyzkov on 23/06/2021.
//

import Foundation
import Combine

import Common

import ComposableArchitecture

public enum Details: Core {
    
    public typealias State = Loadable<Shift, ShiftsError>

    // TODO: separate trigger actions from modifier actions
    // TODO: trigger actions with cancel handler
    // TODO: termination action
    
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
                state = .none
                return .cancel(id: LoadDetailsId())
            case .show(let status):
                state = status
            }
            
            return .none
        }
    }
    
}

//struct LoadAction {
//
//    struct LoadId: Hashable {}
//
//    let cancelTrigger: AnyPublisher<Void, Never>
//
//    lazy var cancel = Effect<LoadAction, Never>.cancel(id: LoadId()).zip(cancelTrigger)
//
//}
