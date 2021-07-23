//
//  ShiftItemView.swift
//  CodingChallenge
//
//  Created by lyzkov on 10/06/2021.
//

import SwiftUI

import Common

extension Shifts.List {
    
    public struct Item: Identifiable, Viewable {
        public let id: String
        public let start: Date
        public let end: Date
        public let facility: String
        
        public init(from entity: Shift) {
            id = entity.id
            start = entity.start
            end = entity.end
            facility = entity.facility.name
        }
        
    }
    
    struct ItemView: SwiftUI.View {
        let item: Item
        
        var body: some SwiftUI.View {
            VStack(alignment: .leading) {
                HStack {
                    Text("Shift ID: ")
                    Text("\(item.id)")
                }
                HStack {
                    Text("Facility: ")
                    Text("\(item.facility)")
                }
                HStack {
                    Text(item.start, style: .date)
                    Spacer()
                    Text(item.end, style: .date)
                }
                .padding(.horizontal, 60.0)
            }
        }
        
    }
    
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        List.ItemView(item: .init(from: .fake()))
    }
}
