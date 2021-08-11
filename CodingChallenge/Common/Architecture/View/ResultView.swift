//
//  ResultView.swift
//  CodingChallenge
//
//  Created by lyzkov on 13/07/2021.
//

import Foundation
import SwiftUI

import ComposableArchitecture

struct ResultView<Item, Fault, Action, Recovery, Content>: ComposableView
where Item: ViewItem, Fault: ViewError, Recovery: View, Content: View {
    typealias State = Result<Item, Fault>

    let store: Store<State, Action>

    let delivery: (Store<Item, Action>) -> Content
    let recovery: (Store<Fault, Action>) -> Recovery

    var body: some View {
        SwitchStore(store) {
            CaseLet(state: /State.success, then: delivery)
            CaseLet(state: /State.failure, then: recovery)
        }
    }

    init(
        with store: Store<State, Action>,
        @ViewBuilder content delivery: @escaping (Store<Item, Action>) -> Content,
        @ViewBuilder recovery: @escaping (Store<Fault, Action>) -> Recovery
    ) {
        self.store = store
        self.delivery = delivery
        self.recovery = recovery
    }

    init(
        with store: Store<State, Action>,
        @ViewBuilder content delivery: @escaping (Store<Item, Action>) -> Content
    ) where Recovery == EmptyView {
        self.store = store
        self.delivery = delivery
        self.recovery = { _ in EmptyView() }
    }

}
