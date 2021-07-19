//
//  ListCore.swift
//  CodingChallenge
//
//  Created by lyzkov on 23/06/2021.
//

import Foundation

import Common

public enum List: Core {
    
    public typealias State = Loadable<[Shift], PoolError>
    
    public enum Action {
        case show
        case load(State)
    }
    
    public typealias Environment = Main.Environment
    
    public static var reducer: List.Reducer {
        .init { state, action, environment in
            switch action {
            case .show:
                state = .pending()
                return environment.pool.shifts()
                    .map(Action.load)
                    .eraseToEffect()
            case .load(let status):
                state = status
            }
            
            return .none
        }
    }
    
}
