//
//  CodingChallangeApp.swift
//  CodingChallange
//
//  Created by Piotr Bogusław Łyczba on 09/06/2021.
//

import SwiftUI

import ComposableArchitecture

@main
struct CodingChallangeApp: App {
    
    private let dependencies = MainDependencyContainer.codingChallangeAppDependencyResolver()
    
    @Weaver(.registration)
    var shiftsStore: Store<ShiftsState, ShiftsAction>
    
    var body: some Scene {
        WindowGroup {
            ShiftsListView(injecting: dependencies)
        }
    }
    
}

extension Store where State == ShiftsState, Action == ShiftsAction {
    
    convenience init() {
        self.init(initialState: ShiftsState(), reducer: shiftsReducer, environment: ShiftsEnvironment())
    }
    
}
