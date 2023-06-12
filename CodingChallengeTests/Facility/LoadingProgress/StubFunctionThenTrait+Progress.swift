//
//  StubFunctionThenTrait+Progress.swift
//  CodingChallengeTests
//
//  Created by lyzkov on 12/06/2023.
//

import Foundation

import Common

import Cuckoo

extension StubFunctionThenTrait {

    @discardableResult
    /// Invokes fake loading progress implementation by using loading progress scheduler.
    /// - Parameters:
    ///   - completed: The final value to finish progress with.
    ///   - scheduler: The loading progress scheduler used to produce steps.
    /// - Returns: Function stub with fake loading progress implementation.
    func then<Item, Fault: Error>(
        completedWith completed: Result<Item, Fault>,
        scheduler: ProgressTestSchedulerOf<DispatchQueue>
    ) -> Self where OutputType == LoadPublisher<Item, Fault> {
        then { _ in
            Load<Item, Fault>.fakeProgress(completedWith: completed, scheduler: scheduler)
        }
    }

}
