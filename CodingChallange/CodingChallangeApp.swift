//
//  CodingChallangeApp.swift
//  CodingChallange
//
//  Created by lyzkov on 09/06/2021.
//

import SwiftUI

import ComposableArchitecture

@main
struct CodingChallangeApp: App {
    
    @Register
    var store: Store<Main.State, Main.Action> = .init(
        initialState: Main.State(),
        reducer: Main.reducer,
        environment: Main.Environment()
    )
    
    var body: some Scene {
        WindowGroup {
            List.View()
        }
    }
    
}
