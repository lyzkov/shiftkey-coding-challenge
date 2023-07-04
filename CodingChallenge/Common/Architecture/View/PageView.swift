//
//  PageView.swift
//
//
//  Created by lyzkov on 29/07/2021.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct PageView<Index, Item, Fault, Action, Header, Placeholder, Content>: ComposableView
where Index: Hashable, Item: ViewItem & Identifiable, Item.Core: Identifiable, Fault: ViewError,
      Header: View, Placeholder: View, Content: View {
    public typealias State = Page<Item, Fault, Index>

    public let store: Store<State, Action>
    let load: (Index) -> Action

    let delivery: (ViewStore<Item, Action>) -> Content
    let progress: (Store<Double?, Action>) -> Placeholder
    let header: (ViewStore<Index, Action>) -> Header

    public var body: some View {
        IfLetStore(store.scope(state: \.items)) { itemsStore in
            Section(
                header: WithViewStore(self.store.scope(state: \Page.index), content: header),
                footer: StatusView(with: itemsStore, progress: progress),
                content: {
                    StatusView(with: itemsStore) { store in
                        ResultView(with: store) { store in
                            ForEachStore(store.scope(state: { $0 }, action: { $1 })) { store in
                                WithViewStore(store, content: delivery)
                            }
                        }
                    }
                }
            )
        } else: {
            WithViewStore(store.scope(state: \.index)) { store in
                TransparentView()
                    .onAppear {
                        store.send(load(store.state))
                    }
            }
        }
    }

    public init(
        with store: Store<State, Action>,
        load: @escaping (Index) -> Action,
        @ViewBuilder content delivery: @escaping (ViewStore<Item, Action>) -> Content,
        @ViewBuilder progress: @escaping (Double?) -> Placeholder,
        @ViewBuilder header: @escaping (Index) -> Header
    ) {
        self.store = store
        self.load = load
        self.delivery = delivery
        self.progress = { store in progress(ViewStore(store).state) }
        self.header = { store in header(store.state) }
    }

}
