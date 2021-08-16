//
//  DetailsCoreSpec.swift
//  CodingChallengeTests
//
//  Created by lyzkov on 01/08/2021.
//

import Foundation
import Combine

@testable import CodingChallenge
import Shifts

import Cuckoo
import Quick
import Nimble
import ComposableArchitecture

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

            func expectStore(toReceive completed: Result<Shift, ShiftsError>) {
                scheduler.advance(by: 4)
                for value in stepsValues {
                    let pending: State = .pending(value)
                    store.receive(.load(pending)) { state in
                        state = pending
                    }
                }
                let succeeded: State = .completed(completed)
                store.receive(.load(succeeded)) { state in
                    state = succeeded
                }
            }
            
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

            it("shows progress completed with success") {
                store.send(.show(id: fake.id))
                expectStore(toReceive: .success(fake))
            }

            context("when identifier is unknown") {
                let unknown = Shift.fake()
                stub(pool) { stub in
                    when(stub.shift(id: unknown.id)).then { _ in
                        steps
                            .progressPublisher(
                                completedWith: .failure(.unknown),
                                scheduler: scheduler.eraseToAnyScheduler()
                            )
                    }
                }

                it("shows progress completing with unknown error") {
                    store.send(.show(id: unknown.id))
                    expectStore(toReceive: .failure(.unknown))
                }
            }
        }
    }
    
}
