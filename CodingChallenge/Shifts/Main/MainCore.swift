//
//  MainCore.swift
//  CodingChallenge
//
//  Created by lyzkov on 24/06/2021.
//

import Foundation

import Common

import ComposableArchitecture

public struct Main: Core {

    public struct State: Resolvable, Equatable {
        var list: List.State = []
        var details: Details.State = .none

        public init() {}
    }

    public enum Action {
        case list(List.Action)
        case details(Details.Action)
    }

    public struct Environment: Resolvable {
        var mainQueue = AnySchedulerOf<DispatchQueue>.main
        var pool: ShiftsPool = DefaultShiftsPool()

        public init() {}
    }

    public static var reducer: Main.Reducer {
        .empty
    }

}

extension Main: Module {

    public static func register() {
        StoreResolver.register(reducer: Reducer.combine(
            Main.reducer,
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
        ))
    }

}
