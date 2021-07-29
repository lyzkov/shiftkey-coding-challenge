//
//  Shift.swift
//  CodingChallenge
//
//  Created by lyzkov on 11/06/2021.
//

import Foundation

import Common

public struct Shift: Identifiable, Equatable {
    public let id: String
    public let kind: Kind?
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

extension Shift: Entity {
    
    public init(from raw: Raw.Shift) {
        self.init(
            id: String(raw.shiftID),
            kind: Kind(rawValue: raw.shiftKind),
            start: raw.startTime,
            end: raw.endTime,
            facility: Facility(name: raw.facilityType.name),
            skill: Skill(name: raw.skill.name),
            specialty: Specialty(name: raw.localizedSpecialty.name)
        )
    }
    
}

extension Shift: Fakeable {
    
    public static func fake() -> Shift {
        Shift(
            id: String(UUID().uuidString.prefix(8)),
            kind: .day,
            start: Date(),
            end: Date().advanced(by: 60*60*9),
            facility: Facility(name: "Skilled Nursing Facility"),
            skill: Skill(name: "Long Term Care"),
            specialty: Specialty(name: "Certified Nursing Aide")
        )
    }
    
}
