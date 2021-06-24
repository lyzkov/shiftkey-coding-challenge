//
//  ShiftItem.swift
//  CodingChallange
//
//  Created by lyzkov on 10/06/2021.
//

import Foundation

extension List {
    
    struct Item: Identifiable, Equatable {
        let id: UUID
        let start: Date
        let end: Date
        let facility: String
    }
    
}

extension List.Item: Fakeable {
    
    static func fake() -> Self {
        Self(
            id: UUID(),
            start: Date(),
            end: Date().addingTimeInterval(5),
            facility: "Skilled Nursing Facility"
        )
    }
    
}

extension List.Item: Viewable {
    typealias Entity = Shift
    
    init(from entity: Shift) {
        id = entity.id
        start = entity.start
        end = entity.end
        facility = entity.facility.name
    }
}

