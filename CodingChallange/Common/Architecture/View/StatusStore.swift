//
//  File.swift
//  
//
//  Created by lyzkov on 13/07/2021.
//

import Foundation
import SwiftUI

import ComposableArchitecture

struct StatusStore<Item, Action, Placeholder: View, Content: View>: View {
    typealias State = Status<Item>
    
    let store: Store<State, Action>
    
    let delivery: (Store<Item, Action>) -> Content
    let progress: (Store<Ratio?, Action>) -> Placeholder
    let load: () -> Void
    
    var body: some View {
        SwitchStore(store) {
            CaseLet(state: /State.completed, then: delivery)
            CaseLet(state: /State.pending, then: progress)
            Default {
                TransparentView().onAppear(perform: load)
            }
        }
    }
    
    public init(
        _ store: Store<State, Action>,
        @ViewBuilder content delivery: @escaping (Store<Item, Action>) -> Content,
        @ViewBuilder progress: @escaping (Store<Ratio?, Action>) -> Placeholder,
        load: @escaping () -> Void
    ) {
        self.store = store
        self.delivery = delivery
        self.progress = progress
        self.load = load
    }
    
}
