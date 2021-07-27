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
        
        public typealias State = IdentifiedArrayOf<PageByDate<Item, Main.Error>>
        
        @Resolve(state: \Main.State.list, action: Main.Action.list)
        var store: Store<State, Action>
        
        @SwiftUI.State var selected: Item? = nil
        
        var forEachStore: Store<State, (Date, Action)> {
            store.scope { state in
                state
            } action: { action in
                Action.show(from: action.0)
            }
        }
        
        public var body: some SwiftUI.View {
            NavigationView {
                SwiftUI.List { // TODO: Paged List with store
                    ForEachStore(forEachStore) { store in
                        let date = ViewStore(store).currentDate
                        LoadStore(store.scope(state: \.items), load: .show(from: date)) { items in
                            if !items.isEmpty {
                                Section {
                                    ForEach(items.state) { item in
                                        List.ItemView(item: item)
                                            .onTapGesture {
                                                selected = item
                                            }
                                    }
                                }
                            }
                        } progress: { store in
                            ProgressView(value: store.state)
                        } recovery: { _ in }
                    }
                }
                .sheet(item: $selected) { item in
                    Details.View(id: item.id)
                }
                .navigationTitle("Shifts")
                .onAppear {
                    ViewStore(store).send(.show())
                }
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
    
    static let fakes = (3...60).map { _ in Shifts.List.Item(from: .fake()) }
    
    static var previews: some SwiftUI.View {
        Shifts.List.View.fake(
            with: [
                Page(index: Date(), items: .completed(.success(.init(uniqueElements: fakes))))
            ]
        )
    }
    
} // Nice parenthesis doom!
