//
//  ShiftsPool.swift
//  
//
//  Created by lyzkov on 15/07/2021.
//

import Foundation
import Combine

import Common

import IdentifiedCollections

class ShiftsPool {
    
    private lazy var client = Client(session: .shared, decoder: .shiftsDecoder)
    
    func shifts() -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError> {
        client.decoded(from: API.availableShifts)
            .mapFault(ShiftsError.init(from:))
            .eraseToLoadPublisher()
    }
    
    func shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError> {
        client.decoded(from: API.availableShifts)
            .mapItem { (shifts: IdentifiedArrayOf<Shift>) in
                guard let shift = shifts[id: id] else {
                    throw ShiftsError.badIdentifier(id: id)
                }
                
                return shift
            }
            .mapFault(ShiftsError.init(from:))
            .eraseToLoadPublisher()
    }
    
}
