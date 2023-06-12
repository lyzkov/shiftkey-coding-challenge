//
//  Load+FakeProgress.swift
//  CodingChallengeTests
//
//  Created by lyzkov on 01/08/2021.
//

import Foundation
import Combine

import Shifts
import Common

import CombineSchedulers

extension Load {

    /// Produces the load publisher from an array of progression fractions that repeatedly emits a pending
    /// status with fractional progress every time interval and then completes with a custom loading status
    /// appended to upstream.
    ///
    /// - Parameters:
    ///   - completed: The result progress publisher completes with.
    ///   - scheduler: The progress scheduler that timely synchronizes fractional progress emission.
    /// - Returns: Publisher faking loading progress in time.
    public static func fakeProgress<Item, Fault: Error>(
        completedWith completed: Result<Item, Fault>,
        scheduler: ProgressTestSchedulerOf<DispatchQueue>
    ) -> LoadPublisher<Item, Fault> {
        LoadPublisher<Item, Fault>(
            from: scheduler.fractions
                .sorted(by: <)
                .map { $0/scheduler.fractions.last! }
                .publisher
                .map(Load.pending)
                .append(.completed(completed))
                .eraseToAnyPublisher(),
            every: .seconds(scheduler.interval),
            scheduler: scheduler.eraseToAnyScheduler()
        )
    }

}

private extension LoadPublisher {

    init(
        from progress: AnyPublisher<Output, Never>,
        every interval: DispatchTimeInterval = .seconds(1),
        scheduler: AnySchedulerOf<DispatchQueue>
    ) where Failure == Never {
        self.init(
            Publishers.Timer(
                every: .init(interval),
                scheduler: scheduler
            ).autoconnect()
            .zip(progress) { $1 }
            .eraseToAnyPublisher()
        )

    }

}
