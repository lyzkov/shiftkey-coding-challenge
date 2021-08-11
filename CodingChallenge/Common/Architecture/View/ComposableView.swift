//
//  ComposableView.swift
//
//
//  Created by lyzkov on 29/07/2021.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public protocol ComposableView: View {
    associatedtype State: ViewItem
    associatedtype Action

    var store: Store<State, Action> { get }
}

#if DEBUG

public protocol FakeView: ComposableView {
    static func fake(with state: State) -> Self
}

#endif
