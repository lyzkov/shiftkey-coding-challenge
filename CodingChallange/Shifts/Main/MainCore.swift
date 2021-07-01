//
//  MainCore.swift
//  CodingChallange
//
//  Created by lyzkov on 24/06/2021.
//

import Foundation

import Common

import ComposableArchitecture

public class Main {
    
    public struct State: MainState, Equatable {
        public var list: List.State = .idle
        public var details: Details.State = .idle
        
        public init() {
        }
    }
    
    public enum Action: MainAction {
        case list(List.Action)
        case details(Details.Action)
    }
    
    public typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>

    @Register
    public var reducer = Reducer.combine(
        [
            effectsReducer,
            List.reducer.pullback(
                state: \State.list,
                action: /Action.list,
                environment: { $0 }
            ),
            Details.reducer.pullback(
                state: \State.details,
                action: /Action.details,
                environment: { $0 }
            )
        ]
    )

    private static let effectsReducer = Reducer { state, action, environment in
        switch action {
        case .list(.load):
            state.list = .loading
            return .init(value: .list(.show(shifts: (3...60).map { _ in .fake() })))
        case .details(.load(let id)):
            state.details = .loading
            if let selected = state.list.items?.first(by: id) {
                return .init(value: .details(.show(shift: selected)))
            }
        default:
            break
        }
        
        return .none
    }
    
    public struct Environment: MainEnvironemnt {
        public init() {
        }
    }
    
    public init() {
    }
    
}

