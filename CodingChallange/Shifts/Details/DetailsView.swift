//
//  ShiftDetailsView.swift
//  CodingChallange
//
//  Created by lyzkov on 10/06/2021.
//

import SwiftUI

import Common

import ComposableArchitecture

extension Details {
    
    public struct View: ComposableView {
        
        public typealias State = Status<Result<Item, Main.Error>>
        
        let id: Item.ID
        
        @Resolve(state: \Main.State.details, action: Main.Action.details)
        var store: Store<State, Action>
        
        public var body: some SwiftUI.View {
            Load(store, load: .load(id: id), unload: .unload) { details in
                NavigationView {
                    Group {
                        VStack(alignment: .leading) {
                            Text("Shift ID: \(details.id)")
                            Text("Facility: \(details.facility)")
                            Text("Skill: \(details.skill)")
                            Text("Specialty: \(details.specialty)")
                            Text("Kind: \(details.kind)")
                            HStack {
                                Text(details.start, style: .date)
                                Spacer()
                                Text(details.end, style: .date)
                            }
                            .padding(.horizontal, 60.0)
                            Spacer()
                        }
                    }
                    .navigationTitle("Shift details")
                }
            } progress: { store in
                ProgressView(value: store.state).animation(.linear)
            } recovery: { store in
                ErrorAlert(store.state,
                    dismiss: { store.send(.unload) },
                    retry: { store.send(.load(id: id)) }
                )
            }
        }
    }
    
}

struct DetailsView_Previews: PreviewProvider, ViewStoreProvider {
    typealias M = Main
    
    static var previews: some SwiftUI.View {
        func firstItemID(viewStore: ViewStore<M.State, M.Action>) -> UUID {
            viewStore.send(.list(.load))
            return (try? viewStore.list.get()?.get().items.first?.id) ?? UUID()
        }
        
        return Details.View(id: firstItemID(viewStore: viewStore))
    }
    
}
