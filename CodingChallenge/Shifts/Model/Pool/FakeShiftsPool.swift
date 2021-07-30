//
//  FakeShiftsPool.swift
//  CodingChallenge
//
//  Created by lyzkov on 19/07/2021.
//

import Foundation
import Combine

import Common

import ComposableArchitecture

class FakeShiftsPool: ShiftsPool {
    
    private static let fakeShifts = IdentifiedArrayOf(
        uniqueElements: (3...60)
            .map { _ in Shift.fake() }
    )
    
    override func shifts(from start: Date) -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError> {
        Just(.completed(.success(Self.fakeShifts))).eraseToAnyPublisher()
    }
    
    override func shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError> {
//        Just(.completed(.success(fakeShifts.[id: id]!))).eraseToAnyPublisher()
        progress(with: .failure(.unknown))
    }
    
    private func progress(steps: Int) -> [Float] {
        (0...steps).map { Float($0)/Float(steps) }
    }
    
    private func progress<Success>(
        with completed: Result<Success, ShiftsError>,
        steps: Int = 10
    ) -> LoadPublisher<Success, ShiftsError> {
        Publishers.Timer(every: 0.1, scheduler: DispatchQueue.main).autoconnect()
            .zip(
                progress(steps: steps)
                    .publisher.map(Status.pending)
                    .append(.completed(completed))
            ) { $1 }
            .eraseToAnyPublisher()
    }
    
    override init() {
        super.init()
    }
    
}