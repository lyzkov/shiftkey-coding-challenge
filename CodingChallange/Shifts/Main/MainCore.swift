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

public struct Main: Core {
    
    public struct State: BranchState, Equatable {
        var list: List.State = .idle
        var details: Details.State = .idle
        public init() {
        }
    }
    
    public enum Action: BranchAction {
        case list(List.Action)
        case details(Details.Action)
    }
    
    public struct Environment: BranchEnvironemnt {
        public init() {
        }
    }
    
    public static var reducer: Main.Reducer {
        .init { state, action, environment in
            struct LoadDetailsId: Hashable {}
            switch action {
            case .list(.load):
                state.list = .pending()
                // TODO: use fake data pool
                return Effect(value: .list(.show(shifts: (3...60).map { _ in .fake() })))
            case .list(.deselect):
                state.details = .idle
            case .details(.load(let id)):
                state.details = .pending(0.60)
                if let selected = try? state.list.get()?.get().items.first(by: id) {
                    // TODO: use fake data pool
                    return Effect(value: .details(.show(shift: selected)))
                        .delay(for: 5, scheduler: AnySchedulerOf<DispatchQueue>.main)
                        .eraseToEffect()
                }
                .cancellable(id: LoadDetailsId(), cancelInFlight: true)
            case .details(.unload):
                return Effect<Action, Never>.merge(
                    .init(value: .list(.deselect)),
                    .cancel(id: LoadDetailsId())
                )
            default:
                break
            }
            
            return .none
        }
    }
    
}

extension Main: ModuleViewable {
    
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
    
    static public func trunkView() -> some SwiftUI.View {
        List.View()
    }
    
    public typealias View = TransparentView<Main.State>
    
}
