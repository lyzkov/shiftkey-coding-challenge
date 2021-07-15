//
//  MainCore.swift
//  CodingChallange
//
//  Created by lyzkov on 24/06/2021.
//

import Foundation
import SwiftUI
import Combine

import Common

import ComposableArchitecture

public struct Main: Core {
    
    public enum Error: ViewableError {
        case unknown(reason: String)
        
        public init(from error: ShiftsError) {
            self = .unknown(reason: error.localizedDescription)
        }
        
        var localizedDescription: String {
            switch self {
            case .unknown(let reason):
                return reason
            }
        }
        
    }
    
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
        let mainQueue = AnySchedulerOf<DispatchQueue>.main
        let pool = ShiftsPool()
        
        public init() {
        }
    }
    
    public static var reducer: Main.Reducer {
        .empty
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
