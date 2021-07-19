//
//  Shift.swift
//  CodingChallenge
//
//  Created by lyzkov on 11/06/2021.
//

import Foundation

import Common

public struct Shift: Identifiable, Equatable {
    public let id: UUID
    public let kind: Kind
    public let start: Date
    public let end: Date
    public let facility: Facility
    public let skill: Skill
    public let specialty: Specialty
}

extension Shift {
    public enum Kind: String {
        case day = "Day Shift"
        case night = "Night Shift"
    }
}

extension Shift: Fakeable {
    
    public static func fake() -> Shift {
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
