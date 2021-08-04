//
//  StatusView.swift
//  CodingChallenge
//
//  Created by lyzkov on 13/07/2021.
//

import Foundation
import SwiftUI

import ComposableArchitecture

struct StatusView<Item: ViewItem, Action, Placeholder: View, Content: View>: ComposableView {
    typealias State = Status<Item>
    
    let store: Store<State, Action>
    
    let delivery: (Store<Item, Action>) -> Content
    let progress: (Store<Float?, Action>) -> Placeholder
    
    var body: some View {
        SwitchStore(store) {
            CaseLet(state: /State.completed, then: delivery)
            CaseLet(state: /State.pending, then: progress)
        }
    }
    
    init(
        with store: Store<State, Action>,
        @ViewBuilder content delivery: @escaping (Store<Item, Action>) -> Content,
        @ViewBuilder progress: @escaping (Store<Float?, Action>) -> Placeholder
    ) {
        self.store = store
        self.delivery = delivery
        self.progress = progress
    }
    
    init(
        with store: Store<State, Action>,
        @ViewBuilder progress: @escaping (Store<Float?, Action>) -> Placeholder
    ) where Content == EmptyView {
        self.store = store
        self.delivery = { _ in EmptyView() }
        self.progress = progress
    }
    
    init(
        with store: Store<State, Action>,
        @ViewBuilder content delivery: @escaping (Store<Item, Action>) -> Content
    ) where Placeholder == EmptyView {
        self.store = store
        self.delivery = delivery
        self.progress = { _ in
            EmptyView()
        }
    }
    
}
