//
//  File.swift
//  
//
//  Created by lyzkov on 15/07/2021.
//

import Foundation
import Combine

import Common

final class ShiftsPool {
    
    typealias FailableStatus<Success, Failure: Error> = Status<Result<Success, Failure>>
    typealias PoolPublisher<S, F: Error> = AnyPublisher<FailableStatus<S, F>, Never>
    
    private let fakeShifts = (3...60).map { _ in Shift.fake() }
    
    func shifts() -> PoolPublisher<[Shift], ShiftsError> {
        Just(.completed(.success(fakeShifts))).eraseToAnyPublisher()
    }
    
    func shift(id: UUID) -> PoolPublisher<Shift, ShiftsError> {
//        Just(.completed(.success(fakeShifts.first(by: id)!))).eraseToAnyPublisher()
//        progress(with: .success(fakeShifts.first(by: id)!))
        progress(with: .failure(.unknown))
    }
    
    private func progress(steps: Int) -> [Float] {
        (0...steps).map { Float($0)/Float(steps) }
    }
    
    private func progress<Success, Failure>(
        with completed: Result<Success, Failure>,
        steps: Int = 10
    ) -> PoolPublisher<Success, Failure> {
        Publishers.Timer(every: 0.1, scheduler: DispatchQueue.main).autoconnect()
            .zip(
                progress(steps: steps)
                    .publisher.map(Status.pending)
                    .append(.completed(completed))
            ) { $1 }
            .eraseToAnyPublisher()
    }
    
}
