//
//  ShiftDetails.swift
//  CodingChallange
//
//  Created by lyzkov on 10/06/2021.
//

import Foundation

struct ShiftDetails: Identifiable, Equatable {
    let id: UUID
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

extension ShiftDetails: Viewable {
    typealias Entity = Shift
    
    init(from entity: Shift) {
        id = entity.id
        facility = entity.facility.name
        skill = entity.skill.name
        specialty = entity.specialty.name
        kind = entity.kind.rawValue
        start = entity.start
        end = entity.end
    }
}
