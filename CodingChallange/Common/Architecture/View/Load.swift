//
//  File.swift
//  
//
//  Created by lyzkov on 13/07/2021.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct Load<
    Item: Viewable, Fault: Error & Equatable, Action,
    Placeholder: View, Recovery: View, Content: View
>: View {
    public typealias State = Status<Result<Item, Fault>>
    
    let store: Store<State, Action>
    let load: Action // unified action for loading view?
    let unload: Action?
    
    let delivery: (ViewStore<Item, Action>) -> Content
    let progress: (ViewStore<Ratio?, Action>) -> Placeholder
    let recovery: (ViewStore<Fault, Action>) -> Recovery
    
    public var body: some View {
        StatusStore(store) { store in
            ResultStore(store) { store in
                WithViewStore(store, content: delivery)
            } recovery: { store in
                WithViewStore(store, content: recovery)
            }
        } progress: { store in
            WithViewStore(store, content: progress)
        }.onAppear {
            ViewStore(store).send(load)
        }.onDisappear {
            if let unload = unload {
                ViewStore(store).send(unload)
            }
        }
    }
    
    public init(
        _ store: Store<State, Action>,
        load: Action,
        unload: Action? = nil,
        @ViewBuilder content delivery: @escaping (ViewStore<Item, Action>) -> Content,
        @ViewBuilder progress: @escaping (ViewStore<Ratio?, Action>) -> Placeholder,
        @ViewBuilder recovery: @escaping (ViewStore<Fault, Action>) -> Recovery
    ) {
        self.store = store
        self.load = load
        self.unload = unload
        self.delivery = delivery
        self.progress = progress
        self.recovery = recovery
    }
    
}
