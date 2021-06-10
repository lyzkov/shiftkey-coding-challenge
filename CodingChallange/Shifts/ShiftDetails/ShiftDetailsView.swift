//
//  ShiftDetailsView.swift
//  CodingChallange
//
//  Created by lyzkov on 10/06/2021.
//

import SwiftUI

struct ShiftDetailsView: View {
    let details: ShiftDetails
    
    var body: some View {
        NavigationView {
            Group {
                VStack(alignment: .leading) {
                    Text("Shift ID: \(details.id.uuidString)")
                    Text("Facility: \(details.facility)")
                    Text("Skill: \(details.skill)")
                    Text("Specialty: \(details.specialty)")
                    Text("Kind: \(details.kind)")
                    HStack {
                        Text(Date(), style: .date)
                        Spacer()
                        Text(Date(), style: .date)
                    }
                    .padding(.horizontal, 60.0)
                    Spacer()
                }
            }
            .navigationTitle(/*@START_MENU_TOKEN@*/"Shift details"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct ShiftDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftDetailsView(details: .fake())
    }
}
