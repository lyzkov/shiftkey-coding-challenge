//
//  ShiftsState.swift
//  CodingChallange
//
//  Created by lyzkov on 11/06/2021.
//

import Foundation

import ComposableArchitecture

struct ShiftsState: Equatable {
    var items: [Shift]
    var selected: Shift?
}

extension ShiftsState {
    
    init() {
        items = []
        selected = nil
    }
    
}
