//
//  Register.swift
//  CodingChallange
//
//  Created by lyzkov on 22/06/2021.
//

import Foundation

@propertyWrapper
struct Register<T: AnyObject> {
    var wrappedValue: T

    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        DependencyContainer.register(wrappedValue)
    }
    
}
