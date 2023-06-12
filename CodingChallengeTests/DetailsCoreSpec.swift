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

import Quick
import Nimble
import Cuckoo
import ComposableArchitecture

class DetailsCoreSpec: QuickSpec {
    
    override func spec() {
        describe("the shift details store") {
            typealias State = Details.State
            typealias Action = Details.Action
            typealias Environment = Details.Environment

            let progress = [0.1, 0.3, 0.5, 0.7, 1.0]

            var store: TestStore<State, State, Action, Action, Environment>!
            let scheduler = DispatchQueue.test(with: progress)
            let pool = MockShiftsPool()

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
                let unknownShift = Shift.fake()
                stub(pool) { pool in
                    when(pool.shift(id: unknownShift.id))
                        .then(
                            completedWith: .failure(.unknown),
                            scheduler: scheduler
                        )
                }
                it("loads progress completing with unknown error") {
                    store.send(.show(id: unknownShift.id))
                    store.expectLoad(with: .failure(.unknown), scheduler: scheduler)
                }
            }

            context("when identifier is well known") {
                let fakeShift = Shift.fake()
                stub(pool) { pool in
                    when(pool.shift(id: fakeShift.id))
                        .then(
                            completedWith: .success(fakeShift),
                            scheduler: scheduler
                        )
                }
                it("loads progress completed with success") {
                    store.send(.show(id: fakeShift.id))
                    store.expectLoad(with: .success(fakeShift), scheduler: scheduler)
                }
            }
        }
    }
    
}

fileprivate extension TestStore where LocalState == Details.State, Action == Details.Action {

    func expectLoad(with completed: LocalState, scheduler: ProgressTestSchedulerOf<DispatchQueue>) {
        scheduler.advance(of: .finalStep)
        receive(progress: scheduler.fractions) { fraction in
            .load(.pending(fraction))
        } update: { state, fraction in
            state = .pending(fraction)
        }
        receive(.load(completed)) { state in
            state = completed
        }
    }

}
