//
//  Array+Shift.swift
//  
//
//  Created by lyzkov on 21/07/2021.
//

import Foundation

import Common

import IdentifiedCollections

extension Array: Entity where Element == Shift {
    
    public init(from rawShifts: Raw.Shifts) {
        self.init(
            rawShifts.data
                .flatMap(\.shifts)
                .map(Shift.init(from:))
        )
    }
    
}

extension IdentifiedArrayOf: Entity where Element == Shift, ID == Element.ID {
    
    public init(from rawShifts: Raw.Shifts) {
        self.init(
            uniqueElements: rawShifts.data
                .flatMap(\.shifts)
                .map(Shift.init(from:))
        )
    }
    
}
