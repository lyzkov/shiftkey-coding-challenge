//
//  ViewStoreProvider.swift
//  
//
//  Created by lyzkov on 08/07/2021.
//

import Foundation

import ComposableArchitecture

public protocol ViewStoreProvider {
    associatedtype State
    associatedtype Action
    
    static var viewStore: ViewStore<State, Action> { get }
}
