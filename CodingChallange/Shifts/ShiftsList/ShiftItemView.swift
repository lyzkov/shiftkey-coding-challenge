//
//  ShiftItemView.swift
//  CodingChallange
//
//  Created by lyzkov on 10/06/2021.
//

import SwiftUI

struct ShiftItemView: View {
    let item: ShiftItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Shift ID: \n\t\(item.id.uuidString)")
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

struct ShiftItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftItemView(item: .fake())
    }
}
