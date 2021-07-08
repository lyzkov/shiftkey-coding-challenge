//
//  ShiftsListCore.swift
//  CodingChallange
//
//  Created by lyzkov on 23/06/2021.
//

import Foundation

import Common

//import ComposableArchitecture

public enum List: Core {
    
    public typealias State = LoadableState<SelectionList<Shift>, Never>
    
    public enum Action {
        case load
        case show(shifts: [Shift])
        case select(id: Shift.ID)
        case deselect
    }
    
    public typealias Environment = Main.Environment
    
    public static var reducer: List.Reducer {
        .effectless { state, action, environment in
            switch (action, state) {
            case (.show(let shifts), .loading):
                state = .completed(.init(items: shifts))
            case (.select(let id), .completed(let list)):
                state = .completed(.init(items: list.items, selected: list.items.first(by: id)))
            case (.deselect, .completed(let list)):
                state = .completed(.init(items: list.items, selected: nil))
            default:
                break
            }
        }
    }
    
}
