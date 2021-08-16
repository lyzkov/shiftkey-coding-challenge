//
//  ClosedRange+Progress.swift
//  CodingChallengeTests
//
//  Created by lyzkov on 01/08/2021.
//

import Foundation
import Combine

import Shifts
import Common

import CombineSchedulers

extension ClosedRange where Self.Bound == Int {
    
    func progressPublisher<Item, Fault: Error>(
        every interval: DispatchTimeInterval = .seconds(1),
        completedWith completed: Result<Item, Fault>,
        scheduler: AnySchedulerOf<DispatchQueue>
    ) -> LoadPublisher<Item, Fault> {
        Publishers.Timer(every: .init(interval), scheduler: scheduler).autoconnect()
                .zip(
                    self.map { Float($0)/Float(count) }
                        .publisher.map(Status.pending)
                        .append(.completed(completed))
                ) { $1 }
                .eraseToAnyPublisher()
    }
    
}
