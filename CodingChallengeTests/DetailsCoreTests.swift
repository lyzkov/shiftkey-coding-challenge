//
//  DetailsCoreTests.swift
//  DetailsCoreTests
//
//  Created by lyzkov on 01/08/2021.
//

import XCTest
import Combine

@testable import CodingChallenge
@testable import Shifts
import Common

import ComposableArchitecture
import Cuckoo

class DetailsCoreTests: XCTestCase {
    
    let scheduler = DispatchQueue.test
    let pool = MockShiftsPool()
    
    typealias State = Details.State
    typealias Action = Details.Action
    typealias Environment = Details.Environment
    var store: TestStore<State, State, Action, Action, Environment>!

    override func setUpWithError() throws {
        store = TestStore(
            initialState: .none,
            reducer: Details.reducer,
            environment: .init(
                scheduler: scheduler.eraseToAnyScheduler(),
                pool: pool
            )
        )
    }

    func testDetailsStoreLoadingUnknownShiftWithProgressCompletesWithUnknownError() throws {
        // Arrange
        let steps = 3
        let unknown = Shift.fake()
        stub(pool) { stub in
            when(stub.shift(id: unknown.id)).then { _ in
                self.progress(with: .failure(.unknown), steps: steps)
            }
        }
        
        // Act
        store.send(.show(id: unknown.id)) {
            $0 = .none
        }
        scheduler.advance(by: 4)
        
        // Assert
        for value in 0...steps {
            let status: State = .pending(Float(value)/Float(steps))
            store.receive(.load(status)) {
                $0 = status
            }
        }
        store.receive(.load(.completed(.failure(.unknown)))) {
            $0 = .completed(.failure(.unknown))
        }
    }
    
    func testDetailsStoreLoadingFakeShiftWithProgressCompletesWithSuccess() throws {
        // Arrange
        let steps = 3
        let fake = Shift.fake()
        stub(pool) { stub in
            when(stub.shift(id: fake.id)).then { _ in
                self.progress(with: .success(fake), steps: steps)
            }
        }
        
        // Act
        store.send(.show(id: fake.id)) {
            $0 = .none
        }
        scheduler.advance(by: 4)
        
        // Assert
        for value in 0...steps {
            let pending: State = .pending(Float(value)/Float(steps))
            store.receive(.load(pending)) {
                $0 = pending
            }
        }
        let succeeded: State = .completed(.success(fake))
        store.receive(.load(succeeded)) {
            $0 = succeeded
        }
    }
    
    private func progress(steps: Int) -> [Float] {
        (0...steps).map { Float($0)/Float(steps) }
    }
    
    private func progress<Success>(
        with completed: Result<Success, ShiftsError>,
        steps: Int = 10
    ) -> LoadPublisher<Success, ShiftsError> {
        Publishers.Timer(every: 0.1, scheduler: scheduler).autoconnect()
            .zip(
                progress(steps: steps)
                    .publisher.map(Status.pending)
                    .append(.completed(completed))
            ) { $1 }
            .eraseToAnyPublisher()
    }

}

extension Main.Environment {
    
    init(scheduler mainQueue: AnySchedulerOf<DispatchQueue>, pool: ShiftsPool) {
        self.init()
        self.mainQueue = mainQueue
        self.pool = pool
    }
    
}
