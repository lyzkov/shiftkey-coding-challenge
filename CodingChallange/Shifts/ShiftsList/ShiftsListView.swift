//
//  ShiftsListView.swift
//  CodingChallenge
//
//  Created by Piotr Bogusław Łyczba on 4/7/21.
//

import SwiftUI

struct ShiftsListView: View {
    let items: [ShiftItem]
    
    var body: some View {
        NavigationView {
            Group {
                List(items) {
                    ShiftItemView(item: $0)
                }
            }
            .navigationTitle("Shifts")
        }
    }
}

struct ShiftsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftsListView(items: (3...60).map { _ in .fake() })
    }
}
