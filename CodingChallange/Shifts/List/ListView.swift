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
    
    public struct View: SwiftUI.View {
        
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
        
        @Resolve(state: \Main.State.list, action: Main.Action.list)
        var store: Store<List.State, List.Action>
        
        private var viewableStore: Store<State, Action> {
            store.scope(state: State.init, action: \.coreAction)
        }
        
        public var body: some SwiftUI.View {
            WithViewStore(viewableStore) { store in
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
        
        public init() {
        }
        
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        List.View()
    }
}
