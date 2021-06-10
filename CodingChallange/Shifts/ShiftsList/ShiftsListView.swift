//
//  ShiftsListView.swift
//  CodingChallenge
//
//  Created by Piotr Bogusław Łyczba on 4/7/21.
//

import SwiftUI

struct ShiftsListView: View {
    var body: some View {
        NavigationView {
            Group {
                List((3...60).map { _ in ShiftItem() }) {
                    Text("Shift ID: \($0.id.uuidString)")
                }
            }
            .navigationTitle("Shifts")
        }
    }
}

struct ShiftsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftsListView()
    }
}
