//
//  DetailsCoreSpec.swift
//  CodingChallengeTests
//
//  Created by lyzkov on 01/08/2021.
//

import Foundation
import Combine
import Quick
import Nimble

@testable import CodingChallenge
import Shifts
import Common

import ComposableArchitecture
import Cuckoo

class DetailsCoreSpec: QuickSpec {
    
    override func spec() {
        describe("the shift details store") {
            typealias State = Details.State
            typealias Action = Details.Action
            typealias Environment = Details.Environment
            var store: TestStore<State, State, Action, Action, Environment>!
            let scheduler = DispatchQueue.test
            let pool = MockShiftsPool()
            
            let steps = 1...3
            let stepsValues = steps.map { value in Float(value) / Float(steps.count) }
            
            beforeEach {
                store = TestStore(
                    initialState: .none,
                    reducer: Details.reducer,
                    environment: .init(
                        scheduler: scheduler.eraseToAnyScheduler(),
                        pool: pool
                    )
                )
            }
            
            context("when identifier is unknown") {
                let unknown = Shift.fake()
                it("shows progress completing with unknown error") {
                    // Arrange
                    stub(pool) { stub in
                        when(stub.shift(id: unknown.id)).then { _ in
                            steps
                                .progressPublisher(
                                    completedWith: .failure(.unknown),
                                    scheduler: scheduler.eraseToAnyScheduler()
                                )
                        }
                    }
                    // Act
                    store.send(.show(id: unknown.id))
                    scheduler.advance(by: 4)
                    // Assert
                    for value in stepsValues {
                        let pending: State = .pending(value)
                        store.receive(.load(pending)) { state in
                            state = pending
                        }
                    }
                    let failed: State = .completed(.failure(.unknown))
                    store.receive(.load(failed)) { state in
                        state = failed
                    }
                }
            }
            // TODO: provide method to arrange any test case that depends upon loading progress
            it("shows progress completed with success") {
                // Arrange
                let fake = Shift.fake()
                stub(pool) { stub in
                    when(stub.shift(id: fake.id)).then { _ in
                        steps
                            .progressPublisher(
                                completedWith: .success(fake),
                                scheduler: scheduler.eraseToAnyScheduler()
                            )
                    }
                }
                // Act
                store.send(.show(id: fake.id)) {
                    $0 = .none
                }
                scheduler.advance(by: 4)
                // Assert
                for value in stepsValues {
                    let pending: State = .pending(value)
                    store.receive(.load(pending)) { state in
                        state = pending
                    }
                }
                let succeeded: State = .completed(.success(fake))
                store.receive(.load(succeeded)) { state in
                    state = succeeded
                }
            }
        }
    }
    
}
