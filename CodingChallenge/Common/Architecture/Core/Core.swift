//
//  Core.swift
//  
//
//  Created by lyzkov on 08/07/2021.
//

import Foundation

import ComposableArchitecture

public protocol Core {
    associatedtype State: Equatable
    associatedtype Action
    associatedtype Environment
    
    typealias Store = ComposableArchitecture.Store<State, Action>
    typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
    
    static var reducer: Reducer { get }
}
