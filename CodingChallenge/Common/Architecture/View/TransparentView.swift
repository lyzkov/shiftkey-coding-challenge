//
//  File.swift
//  
//
//  Created by lyzkov on 11/07/2021.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct TransparentView<CoreState, Action>: ComposableView {
    
    private struct Environment {}
    
    public var store: Store<State, Action>

    public struct State: Viewable, Equatable {
        public init(from entity: CoreState) {
        }
    }

    public var body: some View {
        Color.clear
    }
    
    public init() where CoreState == Void, Action == Void {
        store = .init(initialState: .init(from: ()), reducer: .empty, environment: Environment())
    }

}
