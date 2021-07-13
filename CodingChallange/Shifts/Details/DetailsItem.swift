//
//  ShiftDetails.swift
//  CodingChallange
//
//  Created by lyzkov on 10/06/2021.
//

import Foundation

import Common

extension Details {
    
    public struct Item: Identifiable, Equatable {
        public let id: UUID
        let facility: String
        let skill: String
        let specialty: String
        let kind: String
        let start: Date
        let end: Date
    }
    
}

extension Details.Item: Fakeable {
    
    public static func fake() -> Self {
        Self(
            id: UUID(),
            facility: "Skilled Nursing Facility",
            skill: "Long Term Care",
            specialty: "Certified Nursing Aide",
            kind: "Day Shift",
            start: Date(),
            end: Date().addingTimeInterval(5)
        )
    }
    
}

extension Details.Item: Viewable {
    
    public init(from entity: Shift) {
        id = entity.id
        facility = entity.facility.name
        skill = entity.skill.name
        specialty = entity.specialty.name
        kind = entity.kind.rawValue
        start = entity.start
        end = entity.end
    }
    
}
