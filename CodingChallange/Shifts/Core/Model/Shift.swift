//
//  Shift.swift
//  CodingChallange
//
//  Created by lyzkov on 11/06/2021.
//

import Foundation

struct Shift: Identifiable, Equatable {
    let id: UUID
    let kind: Kind
    let start: Date
    let end: Date
    let facility: Facility
    let skill: Skill
    let specialty: Specialty
}

extension Shift {
    enum Kind: String {
        case day = "Day Shift"
        case night = "Night Shift"
    }
}

extension Shift: Fakeable {
    
    static func fake() -> Shift {
        Shift(
            id: UUID(),
            kind: Kind.day,
            start: Date(),
            end: Date(),
            facility: Facility(name: "Skilled Nursing Facility"),
            skill: Skill(name: "Long Term Care"),
            specialty: Specialty(name: "Certified Nursing Aide")
        )
    }
    
}
