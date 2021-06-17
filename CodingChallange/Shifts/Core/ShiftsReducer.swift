//
//  ShiftsReducer.swift
//  CodingChallange
//
//  Created by lyzkov on 11/06/2021.
//

import Foundation

import ComposableArchitecture

let shiftsReducer = Reducer<ShiftsState, ShiftsAction, ShiftsEnvironment> { state, action, environment in
    switch action {
    case .load:
        state.items = (3...60).map { _ in .fake() }
    case .select(let id):
        state.selected = state.items.first { shift in
            shift.id == id
        }
    case .deselect:
        state.selected = nil
    }
    
    return .none
}
