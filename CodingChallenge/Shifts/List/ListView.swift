//
//  ListView.swift
//  CodingChallenge
//
//  Created by lyzkov on 4/7/21.
//

import SwiftUI

import Common

import ComposableArchitecture

extension Shifts.List {
    
    public struct View: ComposableView {
        
        public typealias State = Load<IdentifiedArrayOf<Item>, Main.Error>?
        
        @Resolve(state: \Main.State.list, action: Main.Action.list)
        var store: Store<State, Action>
        
        @SwiftUI.State var selected: Item? = nil
        
        public var body: some SwiftUI.View {
            LoadStore(store, load: .show) { store in
                NavigationView {
                    SwiftUI.List(store.state) { item in
                        List.ItemView(item: item)
                            .onTapGesture {
                                selected = item
                            }
                    }
                    .sheet(item: $selected) { item in
                        Details.View(id: item.id)
                    }
                    .navigationTitle("Shifts")
                }
            } progress: { store in
                ProgressView(value: store.state)
            } recovery: { _ in
                Text("Ooops")
            }
        }
    }
    
}

extension Shifts.List.View: FakeView {
    
    public static func fake(with state: State) -> Self {
        var view = Self.init()
        view.store = .init(
            initialState: state,
            reducer: .empty,
            environment: Shifts.List.Environment()
        )
        
        return view
    }
    
}

struct ListView_Previews: PreviewProvider {
    
    static var previews: some SwiftUI.View {
        Shifts.List.View.fake(
            with: .completed(
                .success(
                    IdentifiedArrayOf(
                        uniqueElements: (3...60)
                            .map { _ in
                                Shifts.List.Item(from: .fake())
                            }
                    )
                )
            )
        )
    }
    
} // Nice parenthesis doom!
