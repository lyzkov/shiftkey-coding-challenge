//
//  ShiftsListCore.swift
//  CodingChallange
//
//  Created by lyzkov on 23/06/2021.
//

import Foundation

import Common

public enum List: Core {
    
    // TODO: replace selection list?
    public typealias State = Loadable<SelectionList<Shift>, ShiftsError>
    
    public enum Action {
        case load
        case show(Loadable<[Shift], ShiftsError>)
        case select(id: Shift.ID)
        case deselect
    }
    
    public typealias Environment = Main.Environment
    
    public static var reducer: List.Reducer {
        .init { state, action, environment in
            switch action {
            case .load:
                state = .pending()
                return environment.pool.shifts()
                    .map(Action.show)
                    .eraseToEffect()
            case .show(let status):
                state = status?.map { SelectionList(items: $0) }
            case .select(let id):
                state = state?.map { list in
                    SelectionList(items: list.items, selected: list.items.first(by: id))
                }
            case .deselect:
                state = state?.map { list in
                    SelectionList(items: list.items, selected: nil)
                }
            }
            
            return .none
        }
    }
    
}
