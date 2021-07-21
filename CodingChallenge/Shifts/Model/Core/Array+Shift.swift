//
//  Array+Shift.swift
//  
//
//  Created by lyzkov on 21/07/2021.
//

import Foundation

import Common

extension Array: Entity where Element == Shift {
    
    public init(from rawShifts: Raw.Shifts) {
        self.init(
            rawShifts.data
                .flatMap(\.shifts)
                .map(Shift.init(from:))
        )
    }
    
}
