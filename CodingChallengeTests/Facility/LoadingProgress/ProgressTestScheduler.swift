//
//  ProgressTestScheduler.swift
//  CodingChallengeTests
//
//  Created by lyzkov on 12/06/2023.
//

import Foundation
import Combine

import ComposableArchitecture

/// A scheduler whose current time and execution can be controlled in a deterministic manner advancing through fractional progression
/// steps.
///
/// Useful for iterating through the loading progress in advance of steps defined in the `fractions` property. Default `interval` for
/// step is set to 1 second. Underlying implementation for a progress test scheduler is `TestScheduler`.
public final class ProgressTestScheduler<SchedulerTimeType: Strideable, SchedulerOptions>
where SchedulerTimeType.Stride: SchedulerTimeIntervalConvertible {

    public var fractions = [0.0, 1.0]
    public var interval: Int = 1

    public enum Advent {
        case step(number: Int = 1)
        case finalStep
    }

    private let testScheduler: TestScheduler<SchedulerTimeType, SchedulerOptions>

    public init(
        testScheduler: TestScheduler<SchedulerTimeType, SchedulerOptions>,
        fractions: [Double]
    ) {
        self.testScheduler = testScheduler
        self.fractions = fractions
    }

    public func advance(of advent: Advent) {
        switch advent {
        case .step(let number):
            testScheduler.advance(by: .seconds(interval * number))
        case .finalStep:
            testScheduler.advance(by: .seconds(interval * fractions.count + 1))
        }
    }

}

extension ProgressTestScheduler: Scheduler {

    public var now: SchedulerTimeType { testScheduler.now }

    public var minimumTolerance: SchedulerTimeType.Stride { testScheduler.minimumTolerance }

    public func schedule(
        after date: SchedulerTimeType,
        interval: SchedulerTimeType.Stride,
        tolerance: SchedulerTimeType.Stride,
        options: SchedulerOptions?,
        _ action: @escaping () -> Void
    ) -> Cancellable {
        testScheduler.schedule(
            after: date,
            interval: interval,
            tolerance: tolerance,
            options: options,
            action
        )
    }

    public func schedule(
        after date: SchedulerTimeType,
        tolerance: SchedulerTimeType.Stride,
        options: SchedulerOptions?,
        _ action: @escaping () -> Void
    ) {
        testScheduler.schedule(
            after: date,
            tolerance: tolerance,
            options: options,
            action
        )
    }

    public func schedule(
        options: SchedulerOptions?,
        _ action: @escaping () -> Void
    ) {
        testScheduler.schedule(options: options, action)
    }

}

public typealias ProgressTestSchedulerOf<Scheduler> = ProgressTestScheduler<
    Scheduler.SchedulerTimeType,
    Scheduler.SchedulerOptions
> where Scheduler: Combine.Scheduler

extension DispatchQueue {
    /// A fake loading progress test scheduler of dispatch queues.
    public static func test(
        with fractions: [Double]
    ) -> ProgressTestSchedulerOf<DispatchQueue> {
        .init(testScheduler: Self.test, fractions: fractions)
    }

}
