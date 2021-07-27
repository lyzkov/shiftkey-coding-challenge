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
    
    private var buffer: CurrentValueSubject<IdentifiedArrayOf<Shift>, Never> = CurrentValueSubject([])
    
    func shifts(from date: Date) -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError> {
        client.decoded(from: API.availableShifts(from: date))
            .mapFault(ShiftsError.init(from:))
            .handleEvents(receiveOutput: { load in
                if case .completed(.success(let items)) = load {
                    for item in items {
                        self.buffer.value[id: item.id] = item
                    }
                }
            })
            .eraseToLoadPublisher()
    }
    
    func shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError> {
        buffer
            .map { shifts -> Load<Shift, ShiftsError> in
                guard let shift = shifts[id: id] else {
                    return .failure(ShiftsError.badIdentifier(id: id))
                }

                return .success(shift)
            }
            .eraseToAnyPublisher()
    }
    
}
