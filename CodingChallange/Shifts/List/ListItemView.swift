//
//  ShiftItemView.swift
//  CodingChallange
//
//  Created by lyzkov on 10/06/2021.
//

import SwiftUI

extension List {
    
    struct ItemView: SwiftUI.View {
        let item: Item
        
        var body: some SwiftUI.View {
            VStack(alignment: .leading) {
                Text("Shift ID: \n\t\(item.id)")
                Text("Facility: \n\t\(item.facility)")
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
        List.ItemView(item: .fake())
    }
}

