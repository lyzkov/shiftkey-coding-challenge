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
    
    struct View: SwiftUI.View {
        
        struct State: ViewableState {
            let items: [Item]
            let selected: Item?

            init(from coreState: List.State) {
                items = coreState.items?.map(Item.init(from:)) ?? []
                selected = coreState.selected.map(Item.init(from:))
            }
        }
        
        @Resolve(state: \Main.State.list, action: Main.Action.list)
        var store: Store
        
        var body: some SwiftUI.View {
            WithViewStore(store.scope(state: State.init)) { store in
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
                .onAppear {
                    store.send(.load)
                }
            }
        }
        
    }
    
}

//struct ListView_Previews: PreviewProvider {
//    
//    static var previews: some SwiftUI.View {
//        Main.register()
//        return List.View()
//    }
//    
//}
