//
//  DetailsView.swift
//  CodingChallenge
//
//  Created by lyzkov on 10/06/2021.
//

import Combine
import SwiftUI

import Common

import ComposableArchitecture

extension Details {
    
    public struct View: ComposableView {
        
        public typealias State = Loadable<Item, Main.Error>
        
        let id: Item.ID
        
        @Resolve(state: \Main.State.details, action: Main.Action.details)
        var store: Store<State, Action>
        
        public var body: some SwiftUI.View {
            Load(store, load: .show(id: id), unload: .load(.none)) { store in
                NavigationView {
                    Group {
                        Details.ItemView(item: store.state)
                    }
                    .navigationTitle("Shift details")
                }
            } progress: { store in
                ProgressView(value: store.state).animation(.linear)
            } recovery: { store in
                ErrorAlert(store.state,
                    dismiss: { store.send(.load(.none)) },
                    retry: { store.send(.show(id: id)) }
                )
            }
        }
    }
    
}

// TODO: fake view store provider for previews

struct DetailsView_Previews: PreviewProvider {
    
    static var previews: some SwiftUI.View {
        let fake = Shift.fake()
        var view = Details.View(id: fake.id)
        view.store = Store(
            initialState: .init(from: .completed(.success(.fake()))),
            reducer: .empty,
            environment: Details.Environment()
        )
        return view
    }
    
}
