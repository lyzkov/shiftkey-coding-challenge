//
//  MainCore.swift
//  CodingChallange
//
//  Created by lyzkov on 24/06/2021.
//

import Foundation
import SwiftUI

import Common

import ComposableArchitecture

public struct Main: Module {

    @Register
    var reducer = Reducer.combine(
        [
            Reducer { state, action, environment in
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
            },
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
    
    public var view: some View = List.View()
    
    public init() {
    }
    
}

extension Main {
    
    struct State: MainState, Equatable {
        var list: List.State = .idle
        var details: Details.State = .idle
    }
    
    enum Action: MainAction {
        case list(List.Action)
        case details(Details.Action)
    }
    
    struct Environment: MainEnvironemnt {
    }
    
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
}
