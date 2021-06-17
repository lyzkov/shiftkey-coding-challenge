//
//  ShiftsAction.swift
//  CodingChallange
//
//  Created by lyzkov on 11/06/2021.
//

import Foundation

enum ShiftsAction {
    case load
    case select(id: Shift.ID)
    case deselect
}
