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
    
    static public func trunkView() -> some View {
        List.View()
    }
    
}
