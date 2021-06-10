//
//  ShiftsListView.swift
//  CodingChallenge
//
//  Created by Piotr Bogusław Łyczba on 4/7/21.
//

import SwiftUI

struct ShiftsListView: View {
    let items: [ShiftItem]
    @State var selectedItem: ShiftItem?
    
    var body: some View {
        NavigationView {
            Group {
                List(items) { item in
                    ShiftItemView(item: item)
                        .onTapGesture {
                            selectedItem = item
                        }
                }
                .sheet(item: $selectedItem) { item in
                    ShiftDetailsView(details: ShiftDetails.fake())
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
