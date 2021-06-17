//
//  ShiftItem.swift
//  CodingChallange
//
//  Created by Piotr Bogusław Łyczba on 10/06/2021.
//

import Foundation

struct ShiftItem: Identifiable, Equatable {
    let id: UUID
    let start: Date
    let end: Date
    let facility: String
}

extension ShiftItem: Fakeable {
    
    static func fake() -> Self {
        ShiftItem(
            id: UUID(),
            start: Date(),
            end: Date().addingTimeInterval(5),
            facility: "Skilled Nursing Facility"
        )
    }
    
}

extension ShiftItem: Viewable {
    typealias Entity = Shift
    
    init(from entity: Shift) {
        id = entity.id
        start = entity.start
        end = entity.end
        facility = entity.facility.name
    }
}
