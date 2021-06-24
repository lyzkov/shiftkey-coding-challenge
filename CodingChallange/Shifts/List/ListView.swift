//
//  ShiftsListView.swift
//  CodingChallenge
//
//  Created by lyzkov on 4/7/21.
//

import SwiftUI

import ComposableArchitecture

extension List {
    
    struct View: SwiftUI.View {
        
        struct State: ViewableState {
            let items: [Item]
            let selected: Item?

            init(from coreState: List.State?) {
                if case .completed(let list) = coreState {
                    items = list.items.map(Item.init(from:))
                    selected = list.selected.map(Item.init(from:))
                } else {
                    items = []
                    selected = nil
                }
            }
        }
        
        enum Action: ViewableAction {
            case load
            case select(Item)
            case deselect
            
            var coreAction: List.Action {
                switch self {
                case .load:
                    return .load
                case .select(let item):
                    return .select(id: item.id)
                case .deselect:
                    return .deselect
                }
            }
        }
        
        @ViewStore(state: \Main.State.list, action: Main.Action.list)
        var store: Store<State, Action>
        
        var body: some SwiftUI.View {
            WithViewStore(store) { store in
                NavigationView {
                    SwiftUI.List(store.items) { item in
                        ItemView(item: item)
                            .onTapGesture {
                                store.send(.select(item))
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

struct ListView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        List.View()
    }
}
