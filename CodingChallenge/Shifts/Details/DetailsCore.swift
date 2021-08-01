//
//  DetailsCore.swift
//  CodingChallenge
//
//  Created by lyzkov on 23/06/2021.
//

import Foundation

import Common

public enum Details: Core {
    
    public typealias State = Load<Shift, ShiftsError>?
    
    public enum Action: Equatable {
        case show(id: Shift.ID)
        case load(State)
    }
    
    public typealias Environment = Main.Environment

    public static var reducer: Details.Reducer {
        .init { state, action, environment in
            switch action {
            case .show(let id):
                return environment.pool.shift(id: id)
                    .map(Action.load)
                    .receive(on: environment.mainQueue)
                    .eraseToEffect()
            case .load(let status):
                state = status
            }
            
            return .none
        }
    }
    
}
