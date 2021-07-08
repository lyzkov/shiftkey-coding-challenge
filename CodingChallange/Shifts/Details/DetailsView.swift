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
    
    struct View: SwiftUI.View {
        
        struct State: ViewableState {
            let detailed: Item?
            
            init(from coreState: Details.State) {
                detailed = coreState.item.map(Item.init(from:))
            }
        }
        
        let id: Shift.ID
        
        @Resolve(state: \Main.State.details, action: Main.Action.details)
        var store: Store
        
        var body: some SwiftUI.View {
            WithViewStore(store.scope(state: State.init(from:))) { store in
                NavigationView {
                    Group {
                        VStack(alignment: .leading) {
                            if let details = store.detailed {
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
                    }
                    .navigationTitle("Shift details")
                }
                .onAppear {
                    store.send(.load(id: id))
                }
            }
        }
    }
    
}

//struct DetailsView_Previews: PreviewProvider, ViewStoreProvider {
//    
//    static var previews: some SwiftUI.View {
//        func firstItemID(viewStore: ViewStore<State, Action>) -> UUID {
//            viewStore.send(.list(.load))
//            return viewStore.list.items?.first?.id ?? UUID()
//        }
//        
//        return Details.View(id: firstItemID(viewStore: viewStore))
//    }
//    
//}
