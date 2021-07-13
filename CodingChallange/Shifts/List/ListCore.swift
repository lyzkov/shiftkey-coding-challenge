//
//  ShiftsListCore.swift
//  CodingChallange
//
//  Created by lyzkov on 23/06/2021.
//

import Foundation

import Common

public enum List: Core {
    
    public typealias State = Status<Result<SelectionList<Shift>, Never>>
    
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
            case (.show(let shifts), .pending):
                state = .completed(.success(.init(items: shifts)))
            case (.select(let id), .completed(.success(let list))):
                state = .completed(.success(.init(items: list.items, selected: list.items.first(by: id))))
            case (.deselect, .completed(.success(let list))):
                state = .completed(.success(.init(items: list.items, selected: nil)))
            default:
                break
            }
        }
    }
    
}
