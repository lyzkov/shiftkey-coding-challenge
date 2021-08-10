//
//  FeedView.swift
//  CodingChallenge
//
//  Created by lyzkov on 29/07/2021.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct FeedView<Index, Item, Fault, Action, Content>: ComposableView
where Index: Hashable, Item: ViewItem & Identifiable, Item.Core: Identifiable, Fault: ViewError,
      Content: View {
    public typealias State = Feed<Item, Fault, Index>

    public let store: Store<State, Action>
    let onAppear: Action?

    let section: (Store<Page<Item, Fault, Index>, Action>) -> Content

    public var body: some View {
        List {
            ForEachStore(store.scope(state: { $0 }, action: { $1 }), content: section)
        }
        .onAppear {
            if let action = onAppear {
                ViewStore(store).send(action)
            }
        }
    }

    public init(
        with store: Store<State, Action>,
        onAppearSend onAppear: Action? = nil,
        @ViewBuilder content section: @escaping (Store<Page<Item, Fault, Index>, Action>) -> Content
    ) {
        self.store = store
        self.onAppear = onAppear
        self.section = section
    }

}
