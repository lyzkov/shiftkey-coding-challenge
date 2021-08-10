//
//  LoadView.swift
//  CodingChallenge
//
//  Created by lyzkov on 13/07/2021.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct LoadView<Item, Fault, Action, Placeholder, Recovery, Content>: View
where Item: Viewable, Fault: ViewableError, Placeholder: View, Recovery: View, Content: View {
    public typealias State = Load<Item, Fault>?

    let store: Store<State, Action>
    let load: Action
    let unload: Action?

    let delivery: (ViewStore<Item, Action>) -> Content
    let progress: (ViewStore<Float?, Action>) -> Placeholder
    let recovery: (ViewStore<Fault, Action>) -> Recovery

    public var body: some View {
        IfLetStore(store) { store in
            StatusView(with: store) { store in
                ResultView(with: store) { store in
                    WithViewStore(store, content: delivery)
                } recovery: { store in
                    WithViewStore(store, content: recovery)
                }
            } progress: { store in
                WithViewStore(store, content: progress)
            }
        } else: {
            TransparentView()
                .onAppear {
                    ViewStore(store).send(load)
                }
        }.onDisappear {
            if let unload = unload {
                ViewStore(store).send(unload)
            }
        }
    }

    public init(
        with store: Store<State, Action>,
        load: Action,
        unload: Action? = nil,
        @ViewBuilder content delivery: @escaping (ViewStore<Item, Action>) -> Content,
        @ViewBuilder progress: @escaping (Float?) -> Placeholder,
        @ViewBuilder recovery: @escaping (ViewStore<Fault, Action>) -> Recovery
    ) {
        self.store = store
        self.load = load
        self.unload = unload
        self.delivery = delivery
        self.progress = { store in progress(store.state) }
        self.recovery = recovery
    }

}
