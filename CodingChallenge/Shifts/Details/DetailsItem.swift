//
//  DetailsItem.swift
//  CodingChallenge
//
//  Created by lyzkov on 19/07/2021.
//

import SwiftUI

import Common

extension Details {
    
    public struct Item: Identifiable, Viewable {
        public let id: String
        let facility: String
        let skill: String
        let specialty: String
        let kind: String
        let start: Date
        let end: Date
        
        public init(from entity: Shift) {
            id = entity.id
            facility = entity.facility.name
            skill = entity.skill.name
            specialty = entity.specialty.name
            kind = entity.kind?.rawValue ?? ""
            start = entity.start
            end = entity.end
        }
        
    }
    
    struct ItemView: SwiftUI.View {
        let item: Item
        
        var body: some SwiftUI.View {
            VStack(alignment: .leading) {
                Text("Shift ID: \(item.id)")
                Text("Facility: \(item.facility)")
                Text("Skill: \(item.skill)")
                Text("Specialty: \(item.specialty)")
                Text("Kind: \(item.kind)")
                HStack {
                    Text(item.start, style: .date)
                    Spacer()
                    Text(item.end, style: .date)
                }.padding(.horizontal, 60.0)
                Spacer()
            }
        }
        
    }
    
}

#if DEBUG

struct DetailsItemView_Previews: PreviewProvider {
    
    static var previews: some SwiftUI.View {
        Details.ItemView(item: .init(from: .fake()))
    }
    
}

#endif
