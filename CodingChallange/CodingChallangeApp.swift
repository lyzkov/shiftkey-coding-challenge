//
//  CodingChallangeApp.swift
//  CodingChallange
//
//  Created by Piotr Bogusław Łyczba on 09/06/2021.
//

import SwiftUI

@main
struct CodingChallangeApp: App {
    var body: some Scene {
        WindowGroup {
            ShiftsListView(items: shiftItems)
        }
    }
}

let shiftItems = (3...60).map { _ in ShiftItem.fake() }
