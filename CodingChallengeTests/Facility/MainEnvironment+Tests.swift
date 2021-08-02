//
//  MainEnvironment+Tests.swift
//  CodingChallengeTests
//
//  Created by lyzkov on 01/08/2021.
//

import Foundation

@testable import Shifts

import CombineSchedulers

extension Main.Environment {
    
    init(scheduler mainQueue: AnySchedulerOf<DispatchQueue>, pool: ShiftsPool) {
        self.init()
        self.mainQueue = mainQueue
        self.pool = pool
    }
    
}

