//
//  ShiftsListView.swift
//  CodingChallenge
//
//  Created by Piotr Bogusław Łyczba on 4/7/21.
//

import SwiftUI

import ComposableArchitecture

struct ShiftsListView: View {
    
    struct State: ViewableState {
        let items: [ShiftItem]
        let selected: ShiftDetails?
        
        init(from coreState: ShiftsState) {
            items = coreState.items.map(ShiftItem.init(from:))
            selected = coreState.selected.map(ShiftDetails.init(from:))
        }
    }
    
    typealias Action = ShiftsAction
    
    @ViewableStore<State, Action>
    var store = Store(
        initialState: ShiftsState(),
        reducer: shiftsReducer,
        environment: ShiftsEnvironment()
    )
    
    var body: some View {
        WithViewStore($store) { store in
            NavigationView {
                List(store.items) { item in
                    ShiftItemView(item: item)
                        .onTapGesture {
                            store.send(.select(id: item.id))
                        }
                }
                .sheet(item: store.binding(get: \.selected, send: .deselect)) { details in
                    ShiftDetailsView(details: details)
                }
                .navigationTitle("Shifts")
            }
            .onAppear {
                store.send(.load)
            }
        }
    }
    
}

struct ShiftsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftsListView()
    }
}
