//
//  MainCore.swift
//  CodingChallange
//
//  Created by lyzkov on 24/06/2021.
//

import Foundation

import ComposableArchitecture

enum Main {
    
    struct State: Equatable {
        var list: List.State? = nil
        var details: Details.State? = nil
    }
    
    enum Action {
        case list(List.Action)
        case details(Details.Action)
    }
    
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>

    static let reducer = Reducer.combine(
        [
            effectsReducer,
            List.reducer,
            Details.reducer
        ]
    )

    private static let effectsReducer = Reducer { state, action, environment in
        switch action {
        case .list(.load):
            state.list = .loading
            return .init(value: .list(.show(shifts: (3...60).map { _ in .fake() })))
        case .details(.load(let id)):
            state.details = .loading
            if let selected = state.list?.items?.first(by: id) {
                return .init(value: .details(.show(shift: selected)))
            }
        default:
            break
        }
        
        return .none
    }
    
    struct Environment {
    }
    
    enum Error: Swift.Error, Equatable {
        case custom(message: String)
    }
    
}


