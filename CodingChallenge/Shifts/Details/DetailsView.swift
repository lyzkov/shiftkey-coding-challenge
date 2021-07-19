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
                        ItemView(item: store.state)
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

struct DetailsView_Previews: PreviewProvider, ViewStoreProvider {
    typealias Module = Main
    
    static var previews: some SwiftUI.View {
        func firstItemID(viewStore: ViewStore<Module.State, Module.Action>) -> UUID {
            viewStore.send(.list(.show))
            return (try? viewStore.list?.get()?.get().first?.id) ?? UUID()
        }
        
        Module.register()
        return Details.View(id: firstItemID(viewStore: viewStore))
    }
    
}
