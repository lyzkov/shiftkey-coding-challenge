//
//  TestStore+Progress.swift
//  CodingChallengeTests
//
//  Created by lyzkov on 12/06/2023.
//

import Foundation

import Common

import ComposableArchitecture

extension TestStore where LocalState: Equatable, Action: Equatable {

    public func receive<Item, Fault: Error>(
        progress fractions: [Double],
        action expectedPendingAction: (Double) -> Action,
        file: StaticString = #file,
        line: UInt = #line,
        update: @escaping (inout LocalState, Double) throws -> Void = { _, _ in }
    ) where LocalState == Load<Item, Fault>? {
        for fraction in fractions {
            receive(expectedPendingAction(fraction), file: file, line: line) { state in
                try update(&state, fraction)
            }
        }
    }

}
