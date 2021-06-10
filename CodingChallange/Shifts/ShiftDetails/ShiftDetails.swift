//
//  ShiftDetails.swift
//  CodingChallange
//
//  Created by lyzkov on 10/06/2021.
//

import Foundation

struct ShiftDetails: Identifiable {
    let id = UUID()
    let facility: String
    let skill: String
    let specialty: String
    let kind: String
    let start: Date
    let end: Date
}

extension ShiftDetails: Fakeable {
    
    static func fake() -> ShiftDetails {
        ShiftDetails(
            facility: "Skilled Nursing Facility",
            skill: "Long Term Care",
            specialty: "Certified Nursing Aide",
            kind: "Day Shift",
            start: Date(),
            end: Date().addingTimeInterval(5)
        )
    }
    
}
