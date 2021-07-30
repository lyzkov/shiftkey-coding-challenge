//
//  ShiftItemView.swift
//  CodingChallenge
//
//  Created by lyzkov on 10/06/2021.
//

import SwiftUI

import Common

extension Shifts.List {
    
    public struct Item: Identifiable, Viewable, Hashable {
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
                    Spacer()
                    Text("\(item.id)")
                }
                HStack {
                    Text("Facility: ")
                    Spacer()
                    Text("\(item.facility)")
                }
                HStack {
                    Text("Starts: ")
                    Spacer()
                    Text(item.start, style: .date)
                    Text(item.start, style: .time)
                }
                HStack {
                    Text("Ends: ")
                    Spacer()
                    Text(item.end, style: .date)
                    Text(item.end, style: .time)
                }
            }
            .contentShape(Rectangle())
        }
        
    }
    
}

#if DEBUG

struct ListItemView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        List.ItemView(item: .init(from: .fake()))
    }
}

#endif
