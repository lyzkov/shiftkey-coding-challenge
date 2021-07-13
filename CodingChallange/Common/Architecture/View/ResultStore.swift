//
//  File.swift
//  
//
//  Created by lyzkov on 13/07/2021.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct ResultStore<Item, Fault: Error, Action, Recovery: View, Content: View>: View {
    public typealias State = Result<Item, Fault>
    
    let store: Store<State, Action>
    
    let delivery: (Store<Item, Action>) -> Content
    let recovery: (Store<Fault, Action>) -> Recovery
    
    public var body: some View {
        SwitchStore(store) {
            CaseLet(state: /State.success, then: delivery)
            CaseLet(state: /State.failure, then: recovery)
        }
    }
    
    public init(
        _ store: Store<State, Action>,
        @ViewBuilder content delivery: @escaping (Store<Item, Action>) -> Content,
        @ViewBuilder recovery: @escaping (Store<Fault, Action>) -> Recovery
    ) {
        self.store = store
        self.delivery = delivery
        self.recovery = recovery
    }
    
}
