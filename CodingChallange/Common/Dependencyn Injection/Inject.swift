//
//  Inject.swift
//  CodingChallange
//
//  Created by lyzkov on 22/06/2021.
//

import Foundation

@propertyWrapper
struct Inject<T> {
    var wrappedValue: T

    init() {
        wrappedValue = DependencyContainer.resolve()
    }
}
