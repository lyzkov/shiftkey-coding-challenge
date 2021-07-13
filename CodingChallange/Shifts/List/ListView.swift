//
//  ShiftsListView.swift
//  CodingChallenge
//
//  Created by lyzkov on 4/7/21.
//

import SwiftUI

import Common

import ComposableArchitecture

extension List {
    
    public struct View: ComposableView {
        
        public typealias State = Status<Result<SelectionList<Item>, Never>>
        
        @Resolve(state: \Main.State.list, action: Main.Action.list)
        var store: Store<State, Action>
        
        public var body: some SwiftUI.View {
            Load(store, action: .load) { store in
                NavigationView {
                    SwiftUI.List(store.items) { item in
                        List.ItemView(item: item)
                            .onTapGesture {
                                store.send(.select(id: item.id))
                            }
                    }
                    .sheet(item: store.binding(get: \.selected, send: .deselect)) { item in
                        Details.View(id: item.id)
                    }
                    .navigationTitle("Shifts")
                }
            } progress: { store in
                ProgressView(value: store.state?.value)
            } recovery: { _ in
                Text("Ooops")
            }
        }
        
    }
    
}

struct ListView_Previews: PreviewProvider {
    
    static var previews: some SwiftUI.View {
        Main.register()
        return List.View()
    }
    
}
