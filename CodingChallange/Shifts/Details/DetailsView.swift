//
//  ShiftDetailsView.swift
//  CodingChallange
//
//  Created by lyzkov on 10/06/2021.
//

import SwiftUI

import ComposableArchitecture

extension Details {
    
    struct View: SwiftUI.View {
        
        struct State: ViewableState {
            let detailed: Item?
            
            init(from coreState: Details.State?) {
                if case .completed(let shift) = coreState {
                    detailed = .init(from: shift)
                } else {
                    detailed = nil
                }
            }
        }
        
        enum Action: ViewableAction {
            case load(id: Shift.ID)
            
            var coreAction: Details.Action {
                switch self {
                case .load(let id):
                    return .load(id: id)
                }
            }
        }
        
        let id: Shift.ID
        
        @ViewStore(state: \Main.State.details, action: Main.Action.details)
        var store: Store<State, Action>
        
        var body: some SwiftUI.View {
            WithViewStore(store) { store in
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
                    .navigationTitle(/*@START_MENU_TOKEN@*/"Shift details"/*@END_MENU_TOKEN@*/)
                }
                .onAppear {
                    store.send(.load(id: id))
                }
            }
        }
    }
    
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        Details.View(id: List.Item.fake().id)
    }
}
