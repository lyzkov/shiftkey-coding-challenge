//
//  App.swift
//  CodingChallenge
//
//  Created by lyzkov on 09/06/2021.
//

import SwiftUI

import Shifts

@main
struct App: SwiftUI.App {
    
    var body: some Scene {
        WindowGroup {
            Shifts.Main.trunkView()
        }
    }
    
    init() {
        Shifts.Main.register()
    }
    
}
